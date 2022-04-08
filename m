From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 8 Apr 2022 11:40:47 +0700
Subject: [PATCH v6 1/4] ipmi: ssif_bmc: Add SSIF BMC driver
In-Reply-To: <20220317131356.GC3457@minyard.net>
References: <20220310114119.13736-1-quan@os.amperecomputing.com>
 <20220310114119.13736-2-quan@os.amperecomputing.com>
 <20220311011942.GX3457@minyard.net>
 <569f50d5-8f13-280e-b944-6e26d95dc50b@os.amperecomputing.com>
 <20220317131356.GC3457@minyard.net>
Message-ID: <2552a9e2-ca37-c2d3-f636-da18a56bf32e@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 17/03/2022 20:13, Corey Minyard wrote:
> snip...
>>>> +
>>>> +static void response_timeout(struct timer_list *t)
>>>> +{
>>>> +	struct ssif_bmc_ctx *ssif_bmc = from_timer(ssif_bmc, t, response_timer);
>>>> +	unsigned long flags;
>>>> +
>>>
>>> Is there a possible race here?  The timeout can happen at the same time
>>> as a received message, will something bad happen if that's the case?
>>>
>>
>> Thanks Corey,
>> I think I need extra comment here.
>>
>> The purpose of this timeout is to make sure ssif_bmc will recover from busy
>> state in case the upper stack does not provide the response.
>> Hence, the response timeout is set as 500ms, twice the time of max
>> Request-to-Response in spec as the code below. Should it be longer?
> 
> That's not what I was asking.  I know what the timer is for.  But what
> happens if the response comes in at the same time this timer goes off?
> What will keep the data from getting messed up?
> 

Dear Corey, thanks for pointing this out.

In case the response comes in at the same time this timer goes off, both 
timeout handler and the ssif_bmc_write must first win to acquire the 
lock first, eg: ssif_bmc->lock

If timeout handler wins it firstly test ssif_bmc->response_in_progress 
to make sure if the ssif_bmc_write() is succeeded. If not, 
ssif_bmc->response_in_progress is false, then set the ssif_bmc->busy and 
ssif_bmc->response_timer_inited flags to false, and set the flag 
ssif_bmc->aborting = true to start aborting the current response.

If ssif_bmc_write() wins, it then first test if the timer not yet goes 
off, ie: ssif_bmc->response_timer_inited is true, if so, del the timer 
and let the response ready to send back to host. If not, make 
ssif_bmc_write() to return -EINVAL as the driver had already aborted the 
response and wait for the new request.

This will be included in my next version.

>>
>> As per spec, the max Request-to-Respose would not exceed 250ms.
>>
>> I put the comment in ssif_bmc.h as below:
>>>> +/*
>>>> + * IPMI 2.0 Spec, section 12.7 SSIF Timing,
>>>> + * Request-to-Response Time is T6max(250ms) - T1max(20ms) - 3ms = 227ms
>>>> + * Recover ssif_bmc from busy state if it takes upto 500ms
>>>> + */
>>>> +#define RESPONSE_TIMEOUT			500 /* ms */
>>
>>
>>>> +	spin_lock_irqsave(&ssif_bmc->lock, flags);
>>>> +
>>>> +	/* Recover ssif_bmc from busy */
>>>> +	ssif_bmc->busy = false;
>>>> +	del_timer(&ssif_bmc->response_timer);
>>>
>>> You don't need to delete the timer, it's in the timeout.
>>>
>>
>> Will remove this redundant code in next version
>>
>>>> +	ssif_bmc->response_timer_inited = false;
>>>> +
>>>> +	spin_unlock_irqrestore(&ssif_bmc->lock, flags);
>>>> +}
>>>> +
>>>> +/* Called with ssif_bmc->lock held. */
>>>> +static void handle_request(struct ssif_bmc_ctx *ssif_bmc)
>>>> +{
>>>> +	/* set ssif_bmc to busy waiting for response */
>>>> +	ssif_bmc->busy = true;
>>>> +
>>>> +	/* Request message is available to process */
>>>> +	ssif_bmc->request_available = true;
>>>> +
>>>> +	/* Clean old response buffer */
>>>> +	memset(&ssif_bmc->response, 0, sizeof(struct ssif_msg));
>>>> +
>>>> +	/* This is the new READ request.*/
>>>> +	wake_up_all(&ssif_bmc->wait_queue);
>>>> +
>>>> +	/* Armed timer to recover slave from busy state in case of no response */
>>>> +	if (!ssif_bmc->response_timer_inited) {
>>>> +		timer_setup(&ssif_bmc->response_timer, response_timeout, 0);
>>>> +		ssif_bmc->response_timer_inited = true;
>>>> +	}
>>>> +	mod_timer(&ssif_bmc->response_timer, jiffies + msecs_to_jiffies(RESPONSE_TIMEOUT));
>>>> +}
>>>> +
>>>> +static void set_multipart_response_buffer(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
>>>> +{
>>>> +	u8 response_len = 0;
>>>> +	int idx = 0;
>>>> +	u8 data_len;
>>>> +
>>>> +	data_len = ssif_bmc->response.len;
>>>> +	switch (ssif_bmc->smbus_cmd) {
>>>> +	case SSIF_IPMI_MULTIPART_READ_START:
>>>> +		/*
>>>> +		 * Read Start length is 32 bytes.
>>>> +		 * Read Start transfer first 30 bytes of IPMI response
>>>> +		 * and 2 special code 0x00, 0x01.
>>>> +		 */
>>>> +		*val = MAX_PAYLOAD_PER_TRANSACTION;
>>>> +		ssif_bmc->remain_len = data_len - MAX_IPMI_DATA_PER_START_TRANSACTION;
>>>> +		ssif_bmc->block_num = 0;
>>>
>>> Do you need to validate the data length before using this?
>>> This applies for lots of places through here.
>>>
>>
>> set_multipart_response_buffer() is called only when ->is_singlepart_read is
>> false, which is determined by the below code under the *_write()
>>
>> ssif_bmc->is_singlepart_read = (ssif_msg_len(&msg) <=
>> MAX_PAYLOAD_PER_TRANSACTION + 1);
>>
>> So, I think the len is validated and could be use in this functions.
> 
> Ah, I had things backwards.  "Read" here is when you are writing to
> the other side.  I understand now.
> 
>>
>>>> +
>>>> +		ssif_bmc->response_buf[idx++] = 0x00; /* Start Flag */
>>>> +		ssif_bmc->response_buf[idx++] = 0x01; /* Start Flag */
>>>> +		ssif_bmc->response_buf[idx++] = ssif_bmc->response.netfn_lun;
>>>> +		ssif_bmc->response_buf[idx++] = ssif_bmc->response.cmd;
>>>> +		ssif_bmc->response_buf[idx++] = ssif_bmc->response.payload[0];
>>>> +
>>>> +		response_len = MAX_PAYLOAD_PER_TRANSACTION - idx;
>>>> +
>>>> +		memcpy(&ssif_bmc->response_buf[idx], &ssif_bmc->response.payload[1],
>>>> +		       response_len);
>>>> +		break;
>>>> +
>>>> +	case SSIF_IPMI_MULTIPART_READ_MIDDLE:
>>>> +		/*
>>>> +		 * IPMI READ Middle or READ End messages can carry up to 31 bytes
>>>> +		 * IPMI data plus block number byte.
>>>> +		 */
>>>> +		if (ssif_bmc->remain_len < MAX_IPMI_DATA_PER_MIDDLE_TRANSACTION) {
>>>> +			/*
>>>> +			 * This is READ End message
>>>> +			 *  Return length is the remaining response data length
>>>> +			 *  plus block number
>>>> +			 *  Block number 0xFF is to indicate this is last message
>>>> +			 *
>>>> +			 */
>>>> +			*val = ssif_bmc->remain_len + 1;
>>>> +			ssif_bmc->block_num = 0xFF;
>>>> +			ssif_bmc->response_buf[idx++] = ssif_bmc->block_num;
>>>> +			response_len = ssif_bmc->remain_len;
>>>> +			/* Clean the buffer */
>>>> +			memset(&ssif_bmc->response_buf[idx], 0, MAX_PAYLOAD_PER_TRANSACTION - idx);
>>>> +		} else {
>>>> +			/*
>>>> +			 * This is READ Middle message
>>>> +			 *  Response length is the maximum SMBUS transfer length
>>>> +			 *  Block number byte is incremented
>>>> +			 * Return length is maximum SMBUS transfer length
>>>> +			 */
>>>> +			*val = MAX_PAYLOAD_PER_TRANSACTION;
>>>> +			ssif_bmc->remain_len -= MAX_IPMI_DATA_PER_MIDDLE_TRANSACTION;
>>>> +			response_len = MAX_IPMI_DATA_PER_MIDDLE_TRANSACTION;
>>>> +			ssif_bmc->response_buf[idx++] = ssif_bmc->block_num;
>>>> +			ssif_bmc->block_num++;
>>>> +		}
>>>> +
>>>> +		memcpy(&ssif_bmc->response_buf[idx],
>>>> +		       ssif_bmc->response.payload + 1 + ssif_bmc->nbytes_processed,
>>>> +		       response_len);
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		/* Do not expect to go to this case */
>>>> +		dev_err(&ssif_bmc->client->dev,
>>>> +			"%s: Unexpected SMBus command 0x%x\n",
>>>> +			__func__, ssif_bmc->smbus_cmd);
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	ssif_bmc->nbytes_processed += response_len;
>>>> +}
>>>> +
>>>> +/* Process the IPMI response that will be read by master */
>>>> +static void handle_read_processed(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
>>>> +{
>>>> +	u8 *buf;
>>>> +	u8 pec_len, addr, len;
>>>> +	u8 pec = 0;
>>>> +
>>>> +	pec_len = ssif_bmc->pec_support ? 1 : 0;
>>>> +	/* PEC - Start Read Address */
>>>> +	addr = GET_8BIT_ADDR(ssif_bmc->client->addr);
>>>> +	pec = i2c_smbus_pec(pec, &addr, 1);
>>>> +	/* PEC - SSIF Command */
>>>> +	pec = i2c_smbus_pec(pec, &ssif_bmc->smbus_cmd, 1);
>>>> +	/* PEC - Restart Write Address */
>>>> +	addr = addr | 0x01;
>>>> +	pec = i2c_smbus_pec(pec, &addr, 1);
>>>> +
>>>> +	if (ssif_bmc->is_singlepart_read) {
>>>> +		/* Single-part Read processing */
>>>> +		buf = (u8 *)&ssif_bmc->response;
>>>> +
>>>> +		if (ssif_bmc->response.len && ssif_bmc->msg_idx < ssif_bmc->response.len) {
>>>> +			ssif_bmc->msg_idx++;
>>>> +			*val = buf[ssif_bmc->msg_idx];
>>>> +		} else if (ssif_bmc->response.len && ssif_bmc->msg_idx == ssif_bmc->response.len) {
>>>> +			ssif_bmc->msg_idx++;
>>>> +			*val = i2c_smbus_pec(pec, buf, ssif_msg_len(&ssif_bmc->response));
>>>> +		} else {
>>>
>>> I thought for a second that this was wrong, but I think it's correct.
>>> Supply zero if you don't have data.
>>>
>>>> +			*val = 0;
>>>> +		}
>>>> +		/* Invalidate response buffer to denote it is sent */
>>>> +		if (ssif_bmc->msg_idx + 1 >= (ssif_msg_len(&ssif_bmc->response) + pec_len))
>>>> +			complete_response(ssif_bmc);
>>>> +	} else {
>>>> +		/* Multi-part Read processing */
>>>
>>> You don't check the length here like you did above.  I think that's
>>> required.
>>>
>>
>> As per my explanation above, the ->is_singlepart_read is determined by
>> testing the length, so it is validated as I assumed.
>>
>>>> +		switch (ssif_bmc->smbus_cmd) {
>>>> +		case SSIF_IPMI_MULTIPART_READ_START:
>>>> +		case SSIF_IPMI_MULTIPART_READ_MIDDLE:
>>>> +			buf = (u8 *)&ssif_bmc->response_buf;
>>>> +			*val = buf[ssif_bmc->msg_idx];
>>>> +			ssif_bmc->msg_idx++;
>>>> +			break;
>>>> +		default:
>>>> +			/* Do not expect to go to this case */
>>>> +			dev_err(&ssif_bmc->client->dev,
>>>> +				"%s: Unexpected SMBus command 0x%x\n",
>>>> +				__func__, ssif_bmc->smbus_cmd);
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		len = (ssif_bmc->block_num == 0xFF) ?
>>>> +		       ssif_bmc->remain_len + 1 : MAX_PAYLOAD_PER_TRANSACTION;
>>>> +		if (ssif_bmc->msg_idx == (len + 1)) {
>>>> +			pec = i2c_smbus_pec(pec, &len, 1);
>>>> +			*val = i2c_smbus_pec(pec, ssif_bmc->response_buf, len);
>>>> +		}
>>>> +		/* Invalidate response buffer to denote last response is sent */
>>>> +		if (ssif_bmc->block_num == 0xFF &&
>>>> +		    ssif_bmc->msg_idx > (ssif_bmc->remain_len + pec_len)) {
>>>> +			complete_response(ssif_bmc);
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>> +static void handle_write_received(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
>>>> +{
>>>> +	u8 *buf = (u8 *)&ssif_bmc->request;
>>>> +
>>>> +	if (ssif_bmc->msg_idx >= sizeof(struct ssif_msg))
>>>> +		return;
> 
> I don't think this check is valid.  I believe the msg_idx only covers
> the current message, but ssif_msg is a full multi-part message.  It
> covers the single-part message, I think but not the multi-part ones.
> Also, abort the operation and log on bad data.
> 

Yes, thank you for this catch.

Will change in next version.

>>>> +
>>>> +	switch (ssif_bmc->smbus_cmd) {
>>>> +	case SSIF_IPMI_SINGLEPART_WRITE:
>>>> +		buf[ssif_bmc->msg_idx - 1] = *val;
>>>> +		ssif_bmc->msg_idx++;
>>>> +
>>>> +		break;
>>>> +	case SSIF_IPMI_MULTIPART_WRITE_START:
>>>> +		if (ssif_bmc->msg_idx == 1)
>>>> +			ssif_bmc->request.len = 0;
>>>> +
>>>> +		fallthrough;
>>>> +	case SSIF_IPMI_MULTIPART_WRITE_MIDDLE:
>>>> +		/* The len should always be 32 */
>>>> +		if (ssif_bmc->msg_idx == 1 && *val != MAX_PAYLOAD_PER_TRANSACTION)
>>>> +			dev_warn(&ssif_bmc->client->dev,
>>>> +				 "Warn: Invalid Multipart Write len");
> 
> You should abort the operation here.  Don't deliver obviously bad data.
> Same in the code just below.
> 
> This will require that you add a message aborted type of state to just
> ignore everything that comes in until the full sequence ends or a new
> message starts.
> 

Will introduce the abort state which will ignore everything until the 
new request comes to handle those invalid cases.

>>>> +
>>>> +		fallthrough;
>>>> +	case SSIF_IPMI_MULTIPART_WRITE_END:
>>>> +		/* Multi-part write, 2nd byte received is length */
>>>> +		if (ssif_bmc->msg_idx == 1) {
>>>> +			if (*val > MAX_PAYLOAD_PER_TRANSACTION)
>>>> +				dev_warn(&ssif_bmc->client->dev,
>>>> +					 "Warn: Invalid Multipart Write End len");
>>>> +
>>>> +			ssif_bmc->request.len += *val;
>>>> +			ssif_bmc->recv_len = *val;
>>>> +
>>>> +			/* request len should never exceeded 255 bytes */
>>>> +			if (ssif_bmc->request.len > 255)
>>>> +				dev_warn(&ssif_bmc->client->dev,
>>>> +					 "Warn: Invalid request len");
>>>> +
>>>> +		} else {
>>>
>>> You check msg_idx above, but I'm not sure that check will cover this
>>> operation.
>>>
>> That check is to make sure the length (*val) must always be strictly 32
>> bytes in case of MULTIPART_WRITE_START/MIDDLE. And this check allows the
>> length is up to 32 bytes in MULTIPART_WRITE_END.
> 
> Now that I have read and write straight, this is where the previous
> comments apply.
> 
> You are trusting the the length sent by the remote end in the second
> byte is correct, but there is no guarantee of this.  The remote end can
> send as many bytes as it likes.  You need to check that you don't
> overflow buf here and that it actually sends the number of bytes that it
> said it was going to send to avoid underflow.
> 

Will include in next version. The request which is exceeded the 255 
bytes should be aborted.

>>
>>>> +			buf[ssif_bmc->msg_idx - 1 +
>>>> +			    ssif_bmc->request.len - ssif_bmc->recv_len]	= *val;
> 
> This computation is fairly complicated and hard to understand.
> Calculations like this are asking for trouble.
> 
> It would be easier to understand had request.len be the current length
> of what is in request.payload and increment it on every incoming byte.
> Then request.len could be used to add data to the buffer, like
> 
> 	if (ssif_bmc->request.len >= sizeof(ssif_bmc->payload))
> 		error...
> 	ssif_bmc->payload[ssif_bmc->request.len++] = *val;
> 
> If you renamed msg_idx to curr_recv_idx and recv_len to curr_recv_len,
> it would be more clear that these are related and operate on the current
> incoming message.
> 
> It would also be nice to get rid of the casts from ssif_msg to a buffer
> array and just index directly into request.payload[].
> 

Really appreciate for these comments, Corey.
I have rechecked the code and there will be, definitely, changes to 
refactor this code in my next version.

> In thinking about this further, I have a few more observations...
> 
> There is no need to have the netfn and cmd in ssif_msg.  They are just
> the first and second bytes of the message.  You don't care what they
> are in this code.
> 
Agree. Will change in next version

> Why do you deliver the length as part of the message to the user?  The
> length is returned by the system call.  You have all these +1 and -1
> things around the message length, which is error-prone.  Removing the
> length from the message would get rid of all of that.  And using packed
> structures is generally not the best, anyway.
> 

Will avoid those +1, -1 in next version.
About the packed structures, I think it is needed because we want to 
just copy the whole request/response struct from/to user space.

> The PEC calculations remove one byte from the maximum message length.
> Since they are not included in the length byte, it's kind of unnatural
> to do this the way you are doing it.  Instead, it might be best to say
> if you receive a byte and curr_recv_idx == curr_recv_len, process it
> as PEC.  That way the PEC never hits the buffer.
> 
> There is no need for msg_idx, or cur_recv_idx, to be size_t.
> 
> I need to look at this some more, but I'll need to see the rewrite.
> 
> -corey
> 
Thanks Corey,

Will address these suggestions on next version.

- Quan
