From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 25 Sep 2019 15:20:48 -0400
Subject: [v1, 0/1] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569351740-6285-1-git-send-email-hongweiz@ami.com>
References: <1569351740-6285-1-git-send-email-hongweiz@ami.com>
Message-ID: <1569439248-10430-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> > The related SGPIO driver has been accepted and merged into v5.4:
> > _http://patchwork.ozlabs.org/patch/1150357/
> 
> Oh what a mess, it didn't add the necessary code into Kconfig and Makefile, also names it sgpio-gpio.c 
> when everything else is named gpio-sgpio.c.
> 
> I guess I have to fix it up. My fault for missing.
> 
> Linus Walleij

Thanks Linus,

It's not your fault, I misunderstood a earlier comment from another 
reviewer and thought I should wait until the driver is accecpted, 
and then submit the patch to include / enable it.

As Bart suggested, I splitte the patches. 

Regarding the driver name, following the gpio-SoC_name.o convention 
in the Makefile, we choose sgpio-aspeed.o .

--Hongwei
