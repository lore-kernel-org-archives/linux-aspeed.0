From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 31 Jan 2024 11:14:52 +0100
Subject: [PATCH 30 1/7] Add JTAG core driver
In-Reply-To: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <4ce460c4-00ab-4665-8bfa-6f16cdcb38e3@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 31, 2024, at 00:26, Corona, Ernesto wrote:
>
> +static long jtag_ioctl(struct file *file, unsigned int cmd, unsigned 
> long arg)
> +{
> +	struct jtag *jtag = file->private_data;
> +	struct jtag_tap_state tapstate;
> +	struct jtag_xfer xfer;
> +	struct bitbang_packet bitbang;
> +	struct tck_bitbang *bitbang_data;
> +	struct jtag_mode mode;
> +	u8 *xfer_data;
> +	u32 data_size;
> +	u32 value;
> +	u32 active;
> +	int err;
> +
> +	if (!arg)
> +		return -EINVAL;

Why do you need a different return code for one invalid
pointer, compared to any other invalid pointer? It seems
better to just return the -EFAULT from put_user here.

> +	switch (cmd) {
> +	case JTAG_GIOCFREQ:
> +		if (!jtag->ops->freq_get)
> +			return -EOPNOTSUPP;
> +
> +		err = jtag->ops->freq_get(jtag, &value);
> +		if (err)
> +			break;
> +		dev_dbg(jtag->miscdev.parent, "JTAG_GIOCFREQ: freq get = %d",
> +			value);

These dev_dbg() statements look like this is from
code that is not quite ready. There are sometimes
reasons to leave debug prints in a driver, but those
are usually for events that happen asynchronously,
rather than directly being part of a user call.

I would just remove these all.

> +		if (put_user(value, (__u32 __user *)arg))
> +			err = -EFAULT;
> +		break;

The open-coded typecasts look suboptimal, and the function
is rather long. I would suggest you rearrange the ioctl
handler to

- have one function that takes the correct argument type
  (__u32 __user *arg) for each command

- a 'void __user *' variable in the ioctl function itself
  that has a single cast and passes the pointer to those
  functions.

> +
> +		print_hex_dump_debug("O:", DUMP_PREFIX_NONE, 16, 1, xfer_data,
> +				     data_size, false);

If this is enabled, it looks like userspace can produce
a denial-of-service by sending down gigabytes of data
that end up being printed.

> +static const struct file_operations jtag_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= jtag_open,
> +	.llseek		= noop_llseek,
> +	.unlocked_ioctl	= jtag_ioctl,
> +	.release	= jtag_release,
> +};

You should set

       .compat_ioctl = compat_ptr_ioctl

otherwise this driver won't be able to be used from
32-bit applications.

> +struct jtag *jtag_alloc(struct device *host, size_t priv_size,
> +			const struct jtag_ops *ops)
> +{
...
> +
> +	jtag = kzalloc(sizeof(*jtag), GFP_KERNEL);
> +	if (!jtag)
> +		return NULL;
> +	jtag->priv = kzalloc(priv_size, GFP_KERNEL);
> +	if (!jtag->priv)
> +		return NULL;
> +
> +	jtag->ops = ops;
> +	jtag->miscdev.parent = host;
> +
> +	return jtag;
> +}
> +EXPORT_SYMBOL_GPL(jtag_alloc);
> +
> +void jtag_free(struct jtag *jtag)
> +{
> +	kfree(jtag);
> +}
> +EXPORT_SYMBOL_GPL(jtag_free);

You have two 'kzalloc' but only one 'kfree' here. You
also leak the first allocation if the second one fails.

The usual way to do this is to have a single allocation
of 'sizeof(*jtag) + priv_size' and then point
jtag->priv to 'jtag + 1'.

> +struct jtag_tap_state {
> +	__u8	reset;
> +	__u8	from;
> +	__u8	endstate;
> +	__u32	tck;
> +};

This structure has a padding byte inside, which can
leak kernel information when copied back to userspace.
In some cases (not here) the padding can also lead
to incompatible layouts between architectures.

Just add an explicit padding byte and make sure this
gets properly initialized when copying to userspace
and checked for being zero when copied to the kernel.

> +/**
> + * struct jtag_xfer - jtag xfer:
> + *
> + * @type: transfer type
> + * @direction: xfer direction
> + * @from: xfer current state
> + * @endstate: xfer end state
> + * @padding: xfer padding
> + * @length: xfer bits length
> + * @tdio : xfer data array
> + *
> + * Structure provide interface to JTAG device for JTAG SDR/SIR xfer 
> execution.
> + */
> +struct jtag_xfer {
> +	__u8	type;
> +	__u8	direction;
> +	__u8	from;
> +	__u8	endstate;
> +	__u32	padding;
> +	__u32	length;
> +	__u64	tdio;
> +};

This one is indeed incompatible between i386 userland
and x86_64 kernels, and will need explicit padding between
length and tdio.

> +/**
> + * struct bitbang_packet - jtag bitbang array packet:
> + *
> + * @data:   JTAG Bitbang struct array pointer(input/output)
> + * @length: array size (input)
> + *
> + * Structure provide interface to JTAG device for JTAG bitbang bundle 
> execution
> + */
> +struct bitbang_packet {
> +	struct tck_bitbang *data;
> +	__u32	length;
> +} __attribute__((__packed__));

This one has no implicit padding because of the
__attribute__((__packed__)), but that attribute actually
makes things worse since pointers must be naturally aligned
on most architectures.

The pointer also makes this structure incompatible for
32-bit userspace, so you should use the same u64_to_user_ptr()
trick you have elsewhere, or ideally completely avoid the
extra indirection.

> +/**
> + * struct jtag_bitbang - jtag bitbang:
> + *
> + * @tms: JTAG TMS
> + * @tdi: JTAG TDI (input)
> + * @tdo: JTAG TDO (output)
> + *
> + * Structure provide interface to JTAG device for JTAG bitbang 
> execution.
> + */
> +struct tck_bitbang {
> +	__u8	tms;
> +	__u8	tdi;
> +	__u8	tdo;
> +} __attribute__((__packed__));

Here the __packed__ should have no effect here, what is it for?

> +/* ioctl interface */
> +#define __JTAG_IOCTL_MAGIC	0xb9
> +
> +#define JTAG_SIOCSTATE	_IOW(__JTAG_IOCTL_MAGIC, 0, struct 
> jtag_tap_state)
> +#define JTAG_SIOCFREQ	_IOW(__JTAG_IOCTL_MAGIC, 1, unsigned int)
> +#define JTAG_GIOCFREQ	_IOR(__JTAG_IOCTL_MAGIC, 2, unsigned int)
> +#define JTAG_IOCXFER	_IOWR(__JTAG_IOCTL_MAGIC, 3, struct jtag_xfer)
> +#define JTAG_GIOCSTATUS _IOWR(__JTAG_IOCTL_MAGIC, 4, enum 
> jtag_tapstate)

Enums are not good for interface definitions, just use a __u32 here.
I would also list __u32 instead of 'unsigned int' for the others,
though that makes no practical difference.

> +/**
> + * struct tms_cycle - This structure represents a tms cycle state.
> + *
> + * @tmsbits: is the bitwise representation of the needed tms 
> transitions to
> + *           move from one state to another.
> + * @count:   number of jumps needed to move to the needed state.
> + *
> + */
> +struct tms_cycle {
> +	unsigned char tmsbits;
> +	unsigned char count;
> +};

Maybe also use __u8 here.

> +/*
> + * This is the complete set TMS cycles for going from any TAP state to 
> any
> + * other TAP state, following a "shortest path" rule.
> + */
> +static const struct tms_cycle _tms_cycle_lookup[][16] = {
> +/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
> +/* TLR  */{{0x00, 0}, {0x00, 1}, {0x02, 2}, {0x02, 3}, {0x02, 4}, 
> {0x0a, 4},
> +/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
> +	    {0x0a, 5}, {0x2a, 6}, {0x1a, 5}, {0x06, 3}, {0x06, 4}, {0x06, 5},
> +/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
> +	    {0x16, 5}, {0x16, 6}, {0x56, 7}, {0x36, 6} },

It's not clear if this is part of the user ABI of this specific
driver or if it's just generic information about jtag. My feeling
is that this does not belong into this header if this is something
that an application would use regardless of the kernel
interface.

     Arnd
