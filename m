From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 24 Jun 2024 06:46:57 +0200
Subject: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
In-Reply-To: <CACPK8Xes5vp+3YpQ3L5ix=LaDv7oWtqGFVc8moQf4D+o3rnLjg@mail.gmail.com>
References: <20240531193115.3814887-1-robh@kernel.org>
 <CACPK8Xes5vp+3YpQ3L5ix=LaDv7oWtqGFVc8moQf4D+o3rnLjg@mail.gmail.com>
Message-ID: <8dabf3d1-2d23-4adc-a804-2b7aa5fe16e9@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/06/2024 03:55, Joel Stanley wrote:
> On Sat, 1 Jun 2024 at 05:01, Rob Herring (Arm) <robh@kernel.org> wrote:
>>
>> The standard node name for I2C buses is 'i2c'.
> 
> Unfortunately this can't be merged, as it will break userspace. There
> is a lot of code out there that looks up devices based on the device
> tree node path:
> 
> https://github.com/openbmc/phosphor-state-manager/blob/3c1351cc2b63178876ef68f4107c9804d2e17dcc/meson.options#L140

Eh, thanks for sharing.

That's totally stupid user-space. The sysfs path to /sys/devices, or
some grep by compatible, would be fine, but iterating over firmware/DT
is just wrong.

Reminds me USB and ChromeOS. They could fix their userspace, so probably
folks here can as well. I filled a bug.

Best regards,
Krzysztof

