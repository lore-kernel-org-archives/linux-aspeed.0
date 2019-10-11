From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, 11 Oct 2019 16:29:19 +0200
Subject: [PATCH 04/16] mtd: spi-nor: aspeed: Add read training
In-Reply-To: <3244b1ce-587c-6f12-cc9c-7eee0354e76b@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004115919.20788-5-clg@kaod.org>
 <20191011142805.6cc3905c@dhcp-172-31-174-146.wireless.concordia.ca>
 <3244b1ce-587c-6f12-cc9c-7eee0354e76b@kaod.org>
Message-ID: <20191011162919.77b05cf8@dhcp-172-31-174-146.wireless.concordia.ca>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2019 15:55:25 +0200
C?dric Le Goater <clg@kaod.org> wrote:

 
> > (how can you determine if timings are good when IO pins always
> > stay high). Don't we have a command that return non-ff/non-0 data while
> > still being predictable and immutable?   
> 
> Not that I know of on these controllers.

It's not really a controller thing, more a chip thing. The ideal
solution would be to have a loopback mode or an internal SRAM you can
write then read back, but AFAICT it doesn't exists. There's the SFDP
table as Vignesh mentioned, but we have the following problems:

1/ it might be too small (definitely < 16k)
2/ some NORs don't support SFDP (maybe not the ones we care about
   though)


