From: Felipe Balbi <balbi@kernel.org>
Date: Fri, 08 Jan 2021 14:21:14 +0200
Subject: [PATCH 1/1] usb: gadget: aspeed: fix stop dma register setting.
In-Reply-To: <20210108081238.10199-2-ryan_chen@aspeedtech.com>
References: <20210108081238.10199-1-ryan_chen@aspeedtech.com>
 <20210108081238.10199-2-ryan_chen@aspeedtech.com>
Message-ID: <87h7nrwret.fsf@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

Ryan Chen <ryan_chen@aspeedtech.com> writes:
> The vhub engine has two dma mode, one is descriptor list, another
> is single stage DMA. Each mode has different stop register setting.
> Descriptor list operation (bit2) : 0 disable reset, 1: enable reset
> Single mode operation (bit0) : 0 : disable, 1: enable
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

I don't have HW, but FWIW:

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
