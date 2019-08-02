From: Tao Ren <taoren@fb.com>
Date: Fri, 2 Aug 2019 05:20:41 +0000
Subject: [PATCH v2] ARM: dts: aspeed: Add Facebook Wedge100 BMC
In-Reply-To: <CACPK8XcuwNE3aBrsgn-paTZt-EtF6pc6WwYBQef5xc7157bk2g@mail.gmail.com>
References: <20190802041010.1234178-1-taoren@fb.com>
 <CACPK8XcuwNE3aBrsgn-paTZt-EtF6pc6WwYBQef5xc7157bk2g@mail.gmail.com>
Message-ID: <606273F4-E021-4AAF-9F59-F363E4FFF92A@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/1/19, 9:21 PM, "Joel Stanley" <joel@jms.id.au> wrote:

>  On Fri, 2 Aug 2019 at 04:10, Tao Ren <taoren@fb.com> wrote:
>>
>> Add initial version of device tree for Facebook Wedge100 AST2400 BMC
>> platform.
>>
>> Signed-off-by: Tao Ren <taoren@fb.com>
>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>> ---
>>  Changes in v2:
>>  - remove "debug" from bootargs.
>    
> Thanks. I applied wedge40 and then this one fails to apply due to
> conflicts in the Makefile. Next time you have two patches, send them
> as a series they apply one atop the other.

I thought about asking you if I should send them as a series although they are logically independent patches..
Sorry about that and I will do so for future patches.

>  The naming of these two files suggests they come from a family. I
>  noticed there's very minor differences, a pca9548 switch and the use
>  of a watchdog.
>  
>  Are these device trees complete? If yes, do you think it's worthwhile
>  to have a common wedge description in eg.
>  aspeed-bmc-facebook-wedge.dtsi, and put the unique description in
>  respective dts board files?
>   
>  The upside of this is reduced duplication.
>  
>  If you have a reason not to, then that is okay and we can leave it as
>  you submitted them.

Thank you for the suggestion. I'm also considering moving common stuff into "dtsi" file, but let me take care of it in a separate patch, mainly because:
  1) I have one more BMC platform (galaxy100) which is also similar to wedge.
      I haven't started the platform, but once I have galaxy100 device tree ready, it would be easier for me to extract common part.
  2) the device tree is not complete yet.
      For example, all the i2c devices are still created from userspace.
      I'm trying to move the logic from userspace to device tree but I haven't decided what to do with those cpld/fpga devices.


Cheers,

Tao

