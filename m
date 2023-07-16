From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Jul 2023 10:00:00 -0700
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
 <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
Message-ID: <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/16/23 09:08, Krzysztof Kozlowski wrote:

[ ... ]

>>
>> This patch serial doesn't use to binding the fan control h/w. It is
>> used to binding the two independent h/w blocks.
>> One is used to provide pwm output and another is used to monitor the
>> speed of the input.
>> My patch is used to point out that the pwm and the tach is the
>> different function and don't need to
>> bind together. You can not only combine them as the fan usage but also
>> treat them as the individual module for
>> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
>> tach can be used to monitor the heart beat signal.
> 
> Isn't this exactly the same as in every other SoC? PWMs can be used in
> different ways?
> 

... and in every fan controller. Not that it really makes sense because
normally the pwm controller part of such chips is tied to the fan input,
to enable automatic fan control, but it is technically possible.
In many cases this is also the case in SoCs, for example, in ast2500.
Apparently this was redesigned in ast2600 where they two blocks are
only lightly coupled (there are two pwm status bits in the fan status
register, but I have no idea what those mean). If the blocks are tightly
coupled, separate drivers don't really make sense.

There are multiple ways to separate the pwm controller part from the
fan inputs if that is really necessary. One would be to provide a
sequence of address mappings, the other would be to pass the memory
region from an mfd driver. It is not necessary to have N instances
of the fan controller, even if the address space is not continuous.

Guenter

> Anyway, it is tricky to keep the discussion since you avoid posting
> entire DTS. I already said:
> 
> "I will start NAKing such patches without DTS user. It's like reviewing
> fake code for some unknown solution and trying to get from you piece of
> answers one by one, because you do not want to share entire part."
> 
> 
> 
> Best regards,
> Krzysztof
> 

