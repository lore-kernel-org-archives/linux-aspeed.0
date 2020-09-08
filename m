From: wsa@kernel.org <wsa@kernel.org>
Date: Tue, 8 Sep 2020 22:40:51 +0200
Subject: [PATCH v2 2/5] input: misc: Add IBM Operation Panel driver
In-Reply-To: <20200908200101.64974-3-eajames@linux.ibm.com>
References: <20200908200101.64974-1-eajames@linux.ibm.com>
 <20200908200101.64974-3-eajames@linux.ibm.com>
Message-ID: <20200908204051.GA46393@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

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
> +			/*
> +			 * The command is too long and therefore invalid, so set the index
> +			 * to it's largest possible value. When a STOP is finally received,
> +			 * the command will be rejected upon processing.
> +			 */
> +			panel->idx = U8_MAX;
> +		break;
> +	default:
> +		break;
> +	}

Sorry, I missed this in my last review. READ states are mandatory, so
you will need something like this:

+	case I2C_SLAVE_READ_REQUESTED:
+	case I2C_SLAVE_READ_PROCESSED:
+		*val = 0xff;
+		break;


> +	if (command_size)
> +		ibm_panel_process_command(panel, command_size);

I wondered if you could check for the correct command_size here, so no
need to call into the function when the size doesn't match?

> +       rc = i2c_slave_register(client, ibm_panel_i2c_slave_cb);
> +       if (rc) {
> +               input_unregister_device(panel->input);
> +               dev_err(&client->dev,
> +                       "Failed to register I2C slave device: %d\n", rc);

This dev_err can go. The core will print messages if something goes
wrong.

The rest looks good from an I2C point of view.

I'd think this all should go via the input tree?

Kind regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200908/a04ca8c7/attachment.sig>
