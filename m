From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 Jan 2020 16:29:57 +1030
Subject: [PATCH v4 08/12] soc: aspeed: xdma: Add reset ioctl
In-Reply-To: <1577993276-2184-9-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-9-git-send-email-eajames@linux.ibm.com>
Message-ID: <cb602d43-7e00-4d7b-8f05-6b774d573901@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Users of the XDMA engine need a way to reset it if something goes wrong.
> Problems on the host side, or user error, such as incorrect host
> address, may result in the DMA operation never completing and no way to
> determine what went wrong. Therefore, add an ioctl to reset the engine
> so that users can recover in this situation.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
