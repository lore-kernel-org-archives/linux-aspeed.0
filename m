From: 蔡承達 <billyking19920205@gmail.com>
Date: Fri, 14 Jul 2023 19:17:59 +0800
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control documentation
In-Reply-To: <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org> <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com> <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
Message-ID: <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Guenter Roeck <linux@roeck-us.net> ? 2023?7?14? ?? ??6:26???
>
> On 7/14/23 03:18, ??? wrote:
> > Guenter Roeck <linux@roeck-us.net> ? 2023?7?14? ?? ??5:59???
> >>
> >> On 7/14/23 00:13, Krzysztof Kozlowski wrote:
> >>> On 14/07/2023 09:04, ??? wrote:
> >>>
> >>>>           > This is because our register layout for PWM and Tach is not
> >>>> continuous.
> >>>>
> >>>>           > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
> >>>>
> >>>>           > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
> >>>>
> >>>>           > ...
> >>>>
> >>>>           > Each PWM/Tach instance has its own controller register and is not
> >>>> dependent on others.
> >>>
> >>> Your email reply quoting style is very difficult to read.
> >>>
> >>>>
> >>>>
> >>>>
> >>>> Hi Guenter,
> >>>>
> >>>>
> >>>>
> >>>> Did you receive a response to my previous email?
> >>>>
> >>>> I would like to inquire if you have any further concerns regarding the PWM
> >>>> and Tach with 16 instances.
> >>>
> >>> But isn't like this in all PWMs in all SoCs?
> >>>
> >>
> >> Correct, pretty much every fan controller is implemented that way.
> >> I don't understand the logic.
> >>
> >
> > Hi Krzysztof and Guenter,
> >
> > Apologies for any confusion earlier.
> > So, you think that the implementation with 16 instances of TACH/PWM
> > device nodes in dts instead of one is ok to you, right?
> >
>
> Did I say that ? No, it is not ok with me. It is confusing and doesn't make
> sense to me. This is one fan controller with 16 channels, not 16 separate
> controllers.
>

This patch serial doesn't use to binding the fan control h/w. It is
used to binding the two independent h/w blocks.
One is used to provide pwm output and another is used to monitor the
speed of the input.
My patch is used to point out that the pwm and the tach is the
different function and don't need to
bind together. You can not only combine them as the fan usage but also
treat them as the individual module for
use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
tach can be used to monitor the heart beat signal.

Thanks
