From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 31 Jan 2020 19:10:35 +0000
Subject: Some issues while unbinding spi driver
Message-ID: <502948A1-BA1E-4D82-A803-62D625BC37F3@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
I am trying to access BIOS flash device from BMC. To access this flash I need to
do switch a mux gpio to access this flash. After switching GPIO, I bind spi device
via sysfs. After completing access, I unbind this device and switch gpio back.

But issue here is if I switch gpio back (means removing physical access to device)
immediately after unbinding flash with 1 second delay, I lose access to i2c bus 9
which is connected to ME. If I give enough delay like 10 second between unbinding
and GPIO switching, then everything is fine.

The driver used for this is ast2500-spi.

Please share your thoughts.

Regards
-Vijay
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200131/6424b519/attachment.htm>
