From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Date: Wed, 11 Oct 2023 18:27:39 +0700
Subject: [PATCH 0/7] Update the device tree for Ampere's BMC platform
In-Reply-To: <CACPK8Xeo+7hTmfYR-eR9H4teUFqs5vOcSRm_VvDoVOqP4D6+NQ@mail.gmail.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com>
 <CACPK8Xeo+7hTmfYR-eR9H4teUFqs5vOcSRm_VvDoVOqP4D6+NQ@mail.gmail.com>
Message-ID: <92b76d7f-8eaa-48a8-bad0-714101c558d8@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 11/10/2023 15:31, Joel Stanley wrote:
> On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>>
>> Updates the device tree to support some features on Ampere's
>> Mt.Mitchell BMC and Ampere's Mt.Jade BMC.
>>
>> Chanh Nguyen (7):
>>    ARM: dts: aspeed: mtjade, mtmitchell: Update gpio-line-names
>>    ARM: dts: aspeed: mtjade, mtmitchell: Add new gpio-line-names
>>    ARM: dts: aspeed: mtjade: Add the gpio-hog
>>    ARM: dts: aspeed: mtmitchell: Add LEDs
>>    ARM: dts: aspeed: mtmitchell: Add inlet temperature sensor
>>    ARM: dts: aspeed: mtmitchell: Remove redundant ADC configurations
>>    ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port
> 
> I'll merge all patches except patch 4. Please resend that on its own
> once you've added names.

Thank Joel very much! Please also help me push them up at 
https://github.com/openbmc/linux !

I'll resend patch 4 later.

> 
> We should consider creating openbmc documenatiton on recommended LED
> names. Would you be able to help with that?
> 
> Cheers,
> 
> Joel
> 

Yes Joel! I'm glad to help that.


> 
>>
>>   .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  66 ++--
>>   .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 315 ++++++++++++++++--
>>   2 files changed, 334 insertions(+), 47 deletions(-)
>>
>> --
>> 2.17.1
>>
