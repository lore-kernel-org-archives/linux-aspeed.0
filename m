From: Milton Miller II <miltonm@us.ibm.com>
Date: Wed, 12 Jan 2022 01:28:36 +0000
Subject: [PATCH] ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC
Message-ID: <OF56051358.C6261723-ON002587C8.00081CB9-1641950916512@ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My response tagged 


-------- Original Message --------
From: Zev Weiss 
Date: Tue, January 11, 2022 7:15 PM -0600
To: Joel Stanley 
CC: devicetree , linux-aspeed , Arnd Bergmann , Andrew Jeffery , OpenBMC Maillist , Linux Kernel Mailing List , Rob Herring , Neil Horman , Olof Johansson , Anthony Jenkins , Linux ARM 
Subject: [EXTERNAL] Re: [PATCH] ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC


On Tue, Jan 11, 2022 at 02:59:28AM PST, Joel Stanley wrote:
>On Wed, 5 Jan 2022 at 23:10, Zev Weiss wrote:
>>
>> This is a half-width, single-socket Epyc server board with an AST2500
>> BMC.??This device tree is sufficient for basic OpenBMC functionality,
>> but we'll need to add a few more devices (as driver support becomes
>> available) before it's fully usable.
>>
>> Signed-off-by: Zev Weiss 
>
>Reviewed-by: Joel Stanley 
>

Thanks!

>Have you considered using the openbmc gpio naming scheme for the
>gpio-line-names?
>

I looked at it, but decided not to for a few reasons:

??- For systems that are in the early stages of a porting effort (like 
????this one currently is), I'm still referring to hardware schematics 
????fairly often, and using the same identifiers in software that are 
????used in the schematics simplifies things by avoiding an extra
????translation step between the two.

??- Most of the GPIO-related userspace components (that I'm dealing with 
????anyway, e.g. x86-power-control and host-error-monitor) already have 
????their own GPIO line-name configuration/remapping mechanisms that need 
????to be set up anyway.

??- There's a solid mix of GPIOs that would be covered by the naming 
????guidelines and others that aren't; having a mix of the two styles 
????seems a bit awkward to me.

That said, I sympathize with the motivation behind it and I'm not 
vehemently opposed on the whole, so if there's a strong preference to 
follow that scheme I could probably be talked into changing it.



Milton >??Did this assessment take into consideration 
Milton > https://gerrit.openbmc-project.xyz/c/openbmc/docs/+/49863

Milton > is there something that could be improved? 


Zev


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220112/a27af10c/attachment.htm>
