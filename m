From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Oct 2021 07:52:41 -0700
Subject: [PATCH v2] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211019144127.GA12978@gmail.com>
References: <20211019144127.GA12978@gmail.com>
Message-ID: <20211019075241.7ba9fd0a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 19 Oct 2021 20:11:27 +0530 Kumar Thangavel wrote:
>  	len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> -	if (nca->payload < 26)
> +	payload = ALIGN(nca->payload, 4)
> +	if (payload < 26)
>  		len += 26;
>  	else
> -		len += nca->payload;
> +		len += payload;

You round up to 4 and then add 26 if the result is smaller.  26 is not
a multiple of 4. Is this intentional?

Also you can write this on one line:

	len += max(payload, 26);
