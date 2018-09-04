From: Oskar Senft <osk@google.com>
Date: Tue,  4 Sep 2018 16:20:16 -0400
Subject: Aspeed UART routing driver
Message-ID: <20180904202018.198707-1-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

As discussed with Andrew, we have a use case that requires the UART
routing on the AST2500 to be configured at runtime.

After talking with Linus Walleij, we concluded that the pinmux driver is
not a good match for this use case.

I went ahead and implemented a "UART routing control driver" for the
AST2500. It may just work on the AST2400 as is, but I don't have a
system to test on.

Thanks
Oskar.


