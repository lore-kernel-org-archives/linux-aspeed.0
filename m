From: Ninad Palsule <ninad@linux.ibm.com>
Date: Thu, 25 Jan 2024 15:23:56 -0600
Subject: [PATCH v4 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
In-Reply-To: <20240116190321.GA102334@bhelgaas>
References: <20240116190321.GA102334@bhelgaas>
Message-ID: <b5b0e7bd-25e5-49a4-8ac2-349020c2344b@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Bjorn,

On 1/16/24 13:03, Bjorn Helgaas wrote:
> On Tue, Jan 16, 2024 at 12:37:34PM -0600, Ninad Palsule wrote:
>> From: Andrew Geissler <geissonator@yahoo.com>
>>
>> Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.
>> - Added base board
> s/Added/Add/ to match first sentence.
Fixed
>
>> - Added i2c devices and muxes.
>> - Added different voltage regulators.
>> - Added GPIO pin assignements, GPIO expansion devices
>> - Added LED brinker devices
> "brinker"?  "blinker" maybe (no idea what it actually is).
Fixed. Its blinker.
>> - Added Fan controllers
> s/Fan/fan/
Fixed.
>
>> - Added EEPROM/VPD
>> - Added Power supplies
> s/Power/power/
Fixed.
>
>> - Added Humidity, pressure and temperature sensors.
> s/Humidity/humidity/
Fixed.
>
>> - Added Trusted platform module(TPM) chip.
> s/Trusted platform module/Trusted Platform Module /
Fixed
>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> Your sign-off should be last since you are sending the series.

Fixed.

Thanks for the review.

Regards,

Ninad Palsule


