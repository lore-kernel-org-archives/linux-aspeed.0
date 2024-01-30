From: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>
Date: Tue, 30 Jan 2024 15:43:17 -0800
Subject: [PATCH 30 1/7] Add JTAG core driver
In-Reply-To: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <2024013039-tractor-subside-4535@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 30, 2024 at 11:26:19PM +0000, Corona, Ernesto wrote:
> +/**
> + * union pad_config - Padding Configuration:
> + *
> + * @type: transfer type
> + * @pre_pad_number: Number of prepadding bits bit[11:0]
> + * @post_pad_number: Number of prepadding bits bit[23:12]
> + * @pad_data : Bit value to be used by pre and post padding bit[24]
> + * @int_value: unsigned int packed padding configuration value bit[32:0]
> + *
> + * Structure provide pre and post padding configuration in a single __u32
> + */
> +union pad_config {

Bad name for a global structure, don't you think?

> +	struct {
> +		__u32 pre_pad_number	: 12;
> +		__u32 post_pad_number	: 12;
> +		__u32 pad_data		: 1;
> +		__u32 rsvd		: 7;
> +	};

This obviously does not work, please don't do that.

thanks,

greg k-h
