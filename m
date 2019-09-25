From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 25 Sep 2019 15:19:48 -0400
Subject: [v1, 1/1] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569352021-6383-1-git-send-email-hongweiz@ami.com>
References: <1569352021-6383-1-git-send-email-hongweiz@ami.com>
Message-ID: <1569439188-10378-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >  obj-$(CONFIG_GPIO_BD70528)             += gpio-bd70528.o
> > --
> > 2.7.4
> >
> 
> This should be split into separate patches with one extending the binding document and one adding 
> actual support.
> 
> Bart

Thanks Bart,
I just submitted splitted patches.

--Hongwei
