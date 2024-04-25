From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:41:20 -0500
Subject: [PATCH v2] ARM: dts: aspeed: Add IBM P11 BMC boards
In-Reply-To: <48ad6bcccae315e68bc0aa10669eed645c495139.camel@codeconstruct.com.au>
References: <20240415154931.10775-1-eajames@linux.ibm.com>
 <48ad6bcccae315e68bc0aa10669eed645c495139.camel@codeconstruct.com.au>
Message-ID: <7dd9ba1b-6477-4c09-a571-57002cbfa8b7@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/15/24 19:02, Andrew Jeffery wrote:
> On Mon, 2024-04-15 at 10:49 -0500, Eddie James wrote:
>> Add the Blueridge and Fuji BMC systems.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>   - Change "ody" to "odyssey"
>>
>>   arch/arm/boot/dts/aspeed/Makefile             |    2 +
>>   .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1752 +++++++
>>   .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 4016 +++++++++++++++++
>>   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1704 +++++++
>>   4 files changed, 7474 insertions(+)
> A few points:
>
> - Altogether this patch is pretty large. Can we do one for each of the
> FSI topology and the platforms?
>
> - The only list to which you've sent the patch is linux-aspeed, which
> doesn't appear to be archived on lore. Can you please add at least one
> that is? There are a few that should probably be included regardless.
>
> - I don't plan to merge the patch until it has had review from ideally
> more than one other IBMer
>
> On the review front:
>
> It looks like you still need to update
> Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml with the new
> platform compatible strings.
>
> Also, can you please run
>
> ```
> make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-{blueridge,fuji}.dtb
> ```
>
> and address the warnings? This is best done by first applying the patch
> on top of my tree below. It goes some way to eliminating many of the
> warnings currently produced for the Aspeed BMC SoCs:
>
> https://github.com/amboar/linux/tree/dt-warnings/all


Thanks, I've sent v3. One patch has turned into 14 to address the 
warnings... There were still many but they're almost all from 
aspeed-g6.dtsi. The only remaining ones from Blueridge/Fuji that I saw 
were for undocumented compatibles for max31785 and pca955x. Those 
bindings exist but are not in yaml format so the tool doesn't pick them 
up. I'm sure those can be addressed at another time...


Thanks,

Eddie


>
> Andrew
