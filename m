From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Jun 2024 10:49:34 -0600
Subject: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
In-Reply-To: <8dabf3d1-2d23-4adc-a804-2b7aa5fe16e9@kernel.org>
References: <20240531193115.3814887-1-robh@kernel.org> <CACPK8Xes5vp+3YpQ3L5ix=LaDv7oWtqGFVc8moQf4D+o3rnLjg@mail.gmail.com>
 <8dabf3d1-2d23-4adc-a804-2b7aa5fe16e9@kernel.org>
Message-ID: <CAL_Jsq+L6tKw+OzYVHSyou3eW5s7OChEbwqPe=qtQkRW=B+y-w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jun 23, 2024 at 10:47?PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 24/06/2024 03:55, Joel Stanley wrote:
> > On Sat, 1 Jun 2024 at 05:01, Rob Herring (Arm) <robh@kernel.org> wrote:
> >>
> >> The standard node name for I2C buses is 'i2c'.
> >
> > Unfortunately this can't be merged, as it will break userspace. There
> > is a lot of code out there that looks up devices based on the device
> > tree node path:
> >
> > https://github.com/openbmc/phosphor-state-manager/blob/3c1351cc2b63178876ef68f4107c9804d2e17dcc/meson.options#L140
>
> Eh, thanks for sharing.
>
> That's totally stupid user-space. The sysfs path to /sys/devices, or
> some grep by compatible, would be fine, but iterating over firmware/DT
> is just wrong.

Agreed, but Greg (and maybe it is actually documented somewhere) will
tell you that /sys/devices or /sys/bus/ paths are not ABI. /sys/class
is the ABI path.

Rob
