From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 13 Dec 2023 03:23:23 +0000
Subject: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
In-Reply-To: <ed9d28e0-f879-41f3-8679-7ed5e0eec7ce@linaro.org>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
 <20231206174823.ok6rrufhez33rte5@pengutronix.de>
 <ed9d28e0-f879-41f3-8679-7ed5e0eec7ce@linaro.org>
Message-ID: <OSQPR06MB72529B0769B89A21DDFB8B1F8B8DA@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/12/2023 18:48, Uwe Kleine-K?nig wrote:
>> On Tue, Nov 07, 2023 at 11:02:43AM -0800, Guenter Roeck wrote:
>>> On 11/7/23 02:50, Billy Tsai wrote:
>>>> Unlike the old design that the register setting of the TACH should based
>>>> on the configure of the PWM. In ast26xx, the dependency between pwm and
>>>> tach controller is eliminated and becomes a separate hardware block. One
>>>> is used to provide pwm output and another is used to monitor the frequency
>>>> of the input. This driver implements them by exposing two kernel
>>>> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
>>>> existing drivers for controlling elements such as fans (pwm-fan.c),
>>>> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
>>>> provides sysfs interfaces for fan.
>>>>
>>>> Changes since v9:
>>>> Change the type of fan-driving-mode to string
>>>> Fix some typos and formatting issues.
>>>>
>>>
>>> What is the resend about ?
>>
>> And to the original v10 there is a reply by Krzysztof;
>> see https://lore.kernel.org/linux-pwm/3d9e50db-19f0-43b3-8042-2f80a1e7b79e at linaro.org/ .
>>
>> I'll mark the original and this resend as "changes-requested" in our
>> patchwork. Probably the most cooperative way to object is to send a v11
>> and point out the changes compared to v10.

> The resend might be fixing issues from v10, but who knows which and how
> many. In any case it should be v11, not a resend.

I apologize for responding to this question inappropriately. I only replied to Guenter and removed
the others.
The reason for the resend is simply to remove the 'Change-Id' in the commit log, which triggers an
error when running scripts/checkpatch.pl. 
It's a minor issue, and I forgot to mention this change in the cover letter.
I sincerely apologize for any confusion.

Best regards,
Billy Tsai
