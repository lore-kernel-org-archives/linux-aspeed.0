From: Wolfram Sang <wsa@kernel.org>
Date: Tue, 1 Sep 2020 08:11:08 +0200
Subject: [PATCH 2/5] input: misc: Add IBM Operation Panel driver
In-Reply-To: <20200820161152.22751-3-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-3-eajames@linux.ibm.com>
Message-ID: <20200901061108.GB1148@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> +	switch (event) {
> +	case I2C_SLAVE_STOP:
> +		command_size = panel->idx;
> +		fallthrough;
> +	case I2C_SLAVE_WRITE_REQUESTED:
> +		panel->idx = 0;
> +		break;
> +	case I2C_SLAVE_WRITE_RECEIVED:
> +		if (panel->idx < sizeof(panel->command))
> +			panel->command[panel->idx++] = *val;
> +		else
> +			dev_dbg(&panel->input->dev, "command truncated\n");

Just double checking: Do you really want to process truncated commands?
Since you detect the state here, you could also choose to reject such
commands?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200901/2d5dae3a/attachment.sig>
