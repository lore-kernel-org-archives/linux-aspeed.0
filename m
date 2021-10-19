From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Oct 2021 12:07:24 -0700
Subject: [PATCH v2] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211019144127.GA12978@gmail.com>
References: <20211019144127.GA12978@gmail.com>
Message-ID: <20211019120724.50776b81@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 19 Oct 2021 20:11:27 +0530 Kumar Thangavel wrote:
> +	payload = ALIGN(nca->payload, 4)

This is missing a semicolon.
