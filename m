From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 17 Nov 2021 10:23:00 -0800
Subject: [PATCH v6] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211117075513.GA12199@gmail.com>
References: <20211117075513.GA12199@gmail.com>
Message-ID: <20211117102300.68d00e9a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 17 Nov 2021 13:25:13 +0530 Kumar Thangavel wrote:
> +const int padding_bytes = 26;

net/ncsi/ncsi-cmd.c:21:11: warning: symbol 'padding_bytes' was not declared. Should it be static?
