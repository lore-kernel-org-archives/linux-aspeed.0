From: Changming Liu <liu.changm@northeastern.edu>
Date: Sun, 29 Mar 2020 19:37:37 +0000
Subject: [Bug Report] soc/aspeed: integer error in aspeed_p2a_region_acquire
Message-ID: <BL0PR06MB45481A385F546CF5B6855C16E5CA0@BL0PR06MB4548.namprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel and Andrew,

Greetings, I'm a first year PhD student who is interested in the usage of UBSan in the linux kernel, and with some experiments I found that in 
drivers/soc/aspeed/aspeed-p2a-ctrl.c function aspeed_p2a_region_acquire, there is an unsigned integer error which might cause unexpected behavior.

More specifically, the map structure, after the execution of copy_from_user at line 180 in function aspeed_p2a_ioctl, is filled with data from user space.  So the code at line 136 that is

end = map->addr + (map->length - 1);

the subtraction could underflow when map->length equals zero, also, this sum could overflow. As a consequence, the check at line 149 could be bypassed and the following code could be executed.

Although the fact that map->addr is a 64-bit unsigned integer and map->length is 32-bit makes the overflow less likely to happen, it seems doesn't eliminate the possibility entirely. I guess a access_ok could do?

Due to the lack of knowledge of the interaction between this module and the user space, I'm not able to assess if this is security-related problem. I'd appreciate it very much to hear your valuable opinion on why this could not cause any trouble if it's indeed the case, this will help me under linux and UBSAN a lot! and I'm more than happy to provide more information if needed.

Looking forward to your valued response!

Changming Liu
