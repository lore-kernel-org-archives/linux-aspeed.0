From: Corey Minyard <minyard@acm.org>
Date: Wed, 4 May 2022 07:06:31 -0500
Subject: [Openipmi-developer] [PATCH v7 1/3] ipmi: ssif_bmc: Add SSIF BMC
 driver
In-Reply-To: <ec7b86ec-827f-da64-8fd2-eae09f802694@os.amperecomputing.com>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-2-quan@os.amperecomputing.com>
 <20220423015119.GE426325@minyard.net>
 <ec7b86ec-827f-da64-8fd2-eae09f802694@os.amperecomputing.com>
Message-ID: <20220504120631.GE3767252@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 04, 2022 at 01:45:03PM +0700, Quan Nguyen via Openipmi-developer wrote:
> > 
> > I seem to remember mentioning this before, but there is no reason to
> > pack the structures below.
> > 
> 
> The packed structure is because we want to pick the len directly from user
> space without worry about the padding byte.
> 
> As we plan not to use the .h file in next version, I still would like to use
> packed structure internally inside ssif_bmc.c file.

Packed doesn't matter for the userspace API.  If you look at other
structures in the userspace API, they are not packed, either.  The
compiler will do the right thing on both ends.

> 
> > And second, the following is a userspace API structures, so it needs to
> > be in its own file in include/uapi/linux, along with any supporting
> > things that users will need to use.  And your userspace code should be
> > using that file.
> > 
> 
> Meantime, I'd like not to use .h as I see there is no demand for sharing the
> data structure between kernel and user space yet. But we may do it in the
> future.

If you have a userspace API, it needs to be in include/uapi/linux.
You may not be the only user of this code.  In fact, you probably won't
be.  You need to have a .h with the structures in it, you don't want the
same structure in two places if you can help it.

> 
> > > +struct ssif_msg {
> > > +	u8 len;
> > 
> > Just to be 100% safe, it might be better to use a u16 on this.  The spec
> > sort of limits this to 255 bytes, but it also sort of leaves it open to
> > be larger.
> > 
> Yes, u8 only limited to 255 bytes and there is no space for future grow.

Please make it a unsigned int for the length and __u8 for the data to
give necessary flexibility.

Thanks,

-corey

> 
> > > +	u8 payload[MSG_PAYLOAD_LEN_MAX];
> > > +} __packed;
> > > +
> > > +struct ssif_part_buffer {
> > > +	u8 address;
> > > +	u8 smbus_cmd;
> > > +	u8 length;
> > > +	u8 payload[MAX_PAYLOAD_PER_TRANSACTION];
> > > +	u8 pec;
> > > +	u8 index;
> > > +} __packed;
> > > +
> > > +/*
> > > + * SSIF internal states:
> > > + *   SSIF_READY         0x00 : Ready state
> > > + *   SSIF_START         0x01 : Start smbus transaction
> > > + *   SSIF_SMBUS_CMD     0x02 : Received SMBus command
> > > + *   SSIF_REQ_RECVING   0x03 : Receiving request
> > > + *   SSIF_RES_SENDING   0x04 : Sending response
> > > + *   SSIF_BAD_SMBUS     0x05 : Bad SMbus transaction
> > > + */
> > > +enum ssif_state {
> > > +	SSIF_READY,
> > > +	SSIF_START,
> > > +	SSIF_SMBUS_CMD,
> > > +	SSIF_REQ_RECVING,
> > > +	SSIF_RES_SENDING,
> > > +	SSIF_ABORTING,
> > > +	SSIF_STATE_MAX
> > > +};
> > > +
> > > +struct ssif_bmc_ctx {
> > > +	struct i2c_client	*client;
> > > +	struct miscdevice	miscdev;
> > > +	int			msg_idx;
> > > +	bool			pec_support;
> > > +	/* ssif bmc spinlock */
> > > +	spinlock_t		lock;
> > > +	wait_queue_head_t	wait_queue;
> > > +	u8			running;
> > > +	enum ssif_state		state;
> > > +	/* Timeout waiting for response */
> > > +	struct timer_list	response_timer;
> > > +	bool                    response_timer_inited;
> > > +	/* Flag to identify a Multi-part Read Transaction */
> > > +	bool			is_singlepart_read;
> > > +	u8			nbytes_processed;
> > > +	u8			remain_len;
> > > +	u8			recv_len;
> > > +	/* Block Number of a Multi-part Read Transaction */
> > > +	u8			block_num;
> > > +	bool			request_available;
> > > +	bool			response_in_progress;
> > > +	bool			busy;
> > > +	bool			aborting;
> > > +	/* Buffer for SSIF Transaction part*/
> > > +	struct ssif_part_buffer	part_buf;
> > > +	struct ssif_msg		response;
> > > +	struct ssif_msg		request;
> > > +};
> > > +
> > > +static inline struct ssif_bmc_ctx *to_ssif_bmc(struct file *file)
> > > +{
> > > +	return container_of(file->private_data, struct ssif_bmc_ctx, miscdev);
> > > +}
> > > +#endif /* __SSIF_BMC_H__ */
> > > -- 
> > > 2.35.1
> > > 
> > > 
> 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
