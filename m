From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jan 2020 13:09:32 -0800 (PST)
Subject: [net-next PATCH] net/ncsi: Send device address as source address
In-Reply-To: <20200107193034.1322431-1-vijaykhemka@fb.com>
References: <20200107193034.1322431-1-vijaykhemka@fb.com>
Message-ID: <20200108.130932.721413767130819084.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 7 Jan 2020 11:30:33 -0800

> After receiving device mac address from device, send this as
> a source address for further commands instead of broadcast
> address.
> 
> This will help in multi host NIC cards.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to net-next, thanks.
