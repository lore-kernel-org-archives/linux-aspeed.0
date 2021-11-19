From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 18 Nov 2021 22:32:28 -0800
Subject: [PATCH v7] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211118160301.GA19542@gmail.com>
References: <20211118160301.GA19542@gmail.com>
Message-ID: <20211118223228.7edfeade@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 18 Nov 2021 21:33:02 +0530 Kumar Thangavel wrote:
> +const static int padding_bytes = 26;

/net/ncsi/ncsi-cmd.c:21:1: warning: ?static? is not at beginning of declaration [-Wold-style-declaration]
   21 | const static int padding_bytes = 26;
      | ^~~~~
