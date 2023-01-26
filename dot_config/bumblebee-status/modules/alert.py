"""Display a timer
Parameters:
    *alert.default_m minutes
    *alert.default_s seconds
    *alert.notify: command
    *alert.notify_repeat: int
    *alert.paused_icon: icon
    *alert.stopped_icon: icon
    *alert.alarm_icon: icon
    *alert.running_icon: icon
    *alert.reset_to_default: bool
"""

from __future__ import absolute_import
import datetime
from enum import Flag, auto, Enum

import core.module
import core.widget
import core.input
import core.event
import util.cli


class TimerState(Flag):
    Running = auto()
    Stopped = auto()
    Paused = auto()
    Finished = auto()


class Module(core.module.Module):

    def __init__(self, config, theme):
        super().__init__(config, theme, core.widget.Widget(self.full_text))

        self.__default_m = int(self.parameter("default_m", 1))
        self.__default_s = int(self.parameter("default_s", 30))
        self.__notify = self.parameter("notify", "")
        self.__notify_repeat = self.parameter("notify_repeat", 31536000)
        self.__reset_to_default = self.parameter("reset_to_default", False)
        self.__widget_state = ""

        self.__icons = {
            TimerState.Running: self.parameter("running_icon", "󱫠"),
            TimerState.Stopped: self.parameter("stopped_icon", "󱫪"),
            TimerState.Paused: self.parameter("paused_icon", "󱫞"),
            TimerState.Finished: self.parameter("alarm_icon", ""),
        }

        self.__timer_state = TimerState.Stopped
        self.__selected_mode = "s"
        self.__minutes = self.__default_m
        self.__seconds = self.__default_s
        self.__last_notify = datetime.datetime.min

        self.__text = self.format_duration()
        self.__last_tick = datetime.datetime.now()
        self.__current = self.duration()

        core.input.register(self, button=core.input.LEFT_MOUSE, cmd=self.timer_play_pause)
        core.input.register(self, button=core.input.RIGHT_MOUSE, cmd=self.timer_reset)
        core.input.register(self, button=core.input.WHEEL_UP, cmd=self.timer_increment)
        core.input.register(self, button=core.input.WHEEL_DOWN, cmd=self.timer_decrement)

    def duration(self):
        return datetime.timedelta(minutes=self.__minutes, seconds=self.__seconds)

    def format_duration(self, delta=None):
        if delta is None:
            delta = self.duration()

        minutes, seconds = divmod(delta.seconds, 60)
        return f"{minutes:02d}:{seconds:02d}"

    def update(self):
        if self.__timer_state is TimerState.Stopped or self.__timer_state is TimerState.Paused:
            return

        now = datetime.datetime.now()

        self.__current -= now - self.__last_tick
        self.__last_tick = now

        if not self.is_time_left():
            self.__current = datetime.timedelta()
            self.__widget_state = "critical" if self.__widget_state != "critical" else ""
            self.finish()
            self.notify()

        self.__text = self.format_duration(self.__current)

    def full_text(self, widget):
        return f"{self.icon()} {self.__text}"

    def is_time_left(self):
        return self.__current >= datetime.timedelta(seconds=1)

    def icon(self):
        return self.__icons[self.__timer_state]

    def notify(self):
        now = datetime.datetime.now()

        if now < self.__last_notify + datetime.timedelta(seconds=self.__notify_repeat):
            return

        self.__last_notify = now

        if not self.__notify:
            util.cli.execute(f"notify-send {datetime.datetime.now():%H:%M:%S}")
        else:
            util.cli.execute(self.__notify)

    def state(self, widget):
        return self.__widget_state

    def timer_increment(self, widget):
        if self.__timer_state != TimerState.Stopped:
            return

        if self.__selected_mode == "s" and self.__seconds < 59:
            self.__seconds += 1
        elif self.__selected_mode == "m" and self.__minutes < 99:
            self.__minutes += 1

        self.__text = self.format_duration()

    def timer_decrement(self, widget):
        if self.__timer_state != TimerState.Stopped:
            return

        if self.__selected_mode == "s" and self.__seconds >= 1:
            self.__seconds -= 1
        elif self.__selected_mode == "m" and self.__minutes >= 1:
            self.__minutes -= 1

        self.__text = self.format_duration()

    def start(self):
        self.__current = self.duration()
        self.__last_tick = datetime.datetime.now()
        self.__timer_state = TimerState.Running

    def stop(self):
        if self.__reset_to_default:
            self.__minutes = self.__default_m
            self.__seconds = self.__default_s

        self.__current = self.duration()
        self.__text = self.format_duration()
        self.__timer_state = TimerState.Stopped
        self.__widget_state = ""

    def pause(self):
        self.__timer_state = TimerState.Paused

    def resume(self):
        self.__last_tick = datetime.datetime.now()
        self.__timer_state = TimerState.Running

    def finish(self):
        self.__timer_state = TimerState.Finished

    def timer_play_pause(self, widget):
        if self.__timer_state == TimerState.Stopped:
            self.start()
        elif self.__timer_state == TimerState.Running:
            self.pause()
        elif self.__timer_state == TimerState.Paused:
            self.resume()

    def timer_reset(self, widget):
        if self.__timer_state is TimerState.Running:
            self.pause()
            return
        elif self.__timer_state is TimerState.Paused or self.__timer_state is TimerState.Finished:
            self.stop()
            return

        if self.__selected_mode == "s":
            self.__selected_mode = "m"
            self.__text = "__:" + self.format_duration()[3:6]
        else:
            self.__selected_mode = "s"
            self.__text = self.format_duration()[0:2] + ":__"
