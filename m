From: ramakrishnan <ramakrishnan@velankanigroup.com>
Date: Wed, 16 Jun 2021 09:46:31 +0530
Subject: 32 bit Post Code capture and display in AMD EPYC Daytona platform
 with ATS2500 BMC
Message-ID: <17a1308f173.6938bac93765.4526632294642356057@velankanigroup.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,



we are developing openBMC port for the AMD EPYC Daytona platform with ATS 2500 BMC.? I? need the following functionality to be implemented.



1. Capture of the LSB of the 32-bit post code? and lit 8 LEDs on the GPIOAA port? by configuring SNPWADR with one snooping address of 0x0080 and directing the data to the GPIO port pins GPIOAA[7:0].



2. Also read and store the 32-bit Post code as? 4 bytes from the? the LPC I/O write cycles directed to? Port address 0x0080 , 0x0081, 0x0082 and 0x0083? in the root? file system for every power cycle and later display on the web GUI by? Configuring? post code control register PCCR0-3 for? DMA/FIFO mode.?



Could you please let? us know if? implementation for the above said two is available in? openBMC community else suggest implementation? ?pointers.

?

Can any one? provide SW linux kernel 5.x? ?driver for? second functionality? ?implementation or link to driver, if it exist , in the open? community.



suggestion to implementation pointer is also welcome.


?




Regards,

Ramakrishnan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210616/e5d7a3a8/attachment.htm>
