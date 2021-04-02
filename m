From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 2 Apr 2021 16:07:34 +0700
Subject: [PATCH v1 2/3] drivers: char: ipmi: Add Aspeed SSIF BMC driver
In-Reply-To: <CACPK8Xf5d67-KR9AQ9QMcyT2Or9ieF_Q+_RbMMTHt4ckiKi6_A@mail.gmail.com>
References: <20210329121759.5644-1-quan@os.amperecomputing.com>
 <20210329121759.5644-3-quan@os.amperecomputing.com>
 <CACPK8Xf5d67-KR9AQ9QMcyT2Or9ieF_Q+_RbMMTHt4ckiKi6_A@mail.gmail.com>
Message-ID: <e0016596-9ac8-8a54-68bf-42a6959e78be@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 31/03/2021 14:21, Joel Stanley wrote:
> On Mon, 29 Mar 2021 at 12:18, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>>
>> The SMBus system interface (SSIF) IPMI BMC driver can be used to perform
>> in-band IPMI communication with their host in management (BMC) side.
>>
>> This commits adds support specifically for Aspeed AST2500 which commonly
>> used as Board Management Controllers.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> I don't have any SSIF or IPMI related feedback on your patch, but some
> general things I noticed when reading it.
> 

Thank you, Joel,
I'm really appreciate your comments for this patch series.

And, as there is a compilation error detected by kernel robot test, I 
was hurry to send out v2 just to fix that just before your email 
arrived. So I'd like to address all comments in my upcoming v3.


>> ---
>>   drivers/char/ipmi/Kconfig           |  22 +
>>   drivers/char/ipmi/Makefile          |   2 +
>>   drivers/char/ipmi/ssif_bmc.c        | 645 ++++++++++++++++++++++++++++
>>   drivers/char/ipmi/ssif_bmc.h        |  92 ++++
>>   drivers/char/ipmi/ssif_bmc_aspeed.c | 132 ++++++
>>   5 files changed, 893 insertions(+)
>>   create mode 100644 drivers/char/ipmi/ssif_bmc.c
>>   create mode 100644 drivers/char/ipmi/ssif_bmc.h
>>   create mode 100644 drivers/char/ipmi/ssif_bmc_aspeed.c
> 
> It would make sense to split the aspeed implementation into a separate
> patch form the ssif framework.
> 
Yes, will do in next version

>> +++ b/drivers/char/ipmi/ssif_bmc.c
>> @@ -0,0 +1,645 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * The driver for BMC side of SSIF interface
>> + *
>> + * Copyright (c) 2021, Ampere Computing LLC
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <https://www.gnu.org/licenses/>.
> 
> You should omit the licence text; it is replaced by the SPDX tags.
> 
My bad, will remove in next version

>> +static int send_ssif_bmc_response(struct ssif_bmc_ctx *ssif_bmc, bool non_blocking)
>> +{
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       if (!non_blocking) {
>> +retry:
>> +               ret = wait_event_interruptible(ssif_bmc->wait_queue,
>> +                                              !ssif_bmc->response_in_progress);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       spin_lock_irqsave(&ssif_bmc->lock, flags);
> 
> What's the lock doing here? We've just waited for response_in_progress
> to be false, so we then take the lock to check what value it is?
> Should it also be sending some data in this function?
> 
The lock is to make sure ssif_bmc->response_in_progress are completely 
processed, ie: when the lock already released.
My concern is that reference to that value without acquiring lock may 
not be true as it is under other possess.

In fact, the lock here is for the whole data pointed by ssif_bmc 
pointer. Hence, every reference/modify to this data must be done with 
the lock acquired.

>> +       if (ssif_bmc->response_in_progress) {
>> +               spin_unlock_irqrestore(&ssif_bmc->lock, flags);
>> +               if (non_blocking)
>> +                       return -EAGAIN;
>> +
>> +               goto retry;
> 
> The goto threw me, so I tried re-writing it without. Again, I don't
> quite follow what the spinlock is doing.
> 
> while (1) {
>      if (blocking) {
>          ret = wait_event_interruptible();
>          if (ret)
>               return ret;
>      }
> 
>       spin_lock_irqsave()
>       if (ssif_bmc->response_in_progress) {
>           spin_lock_irqrestore()
>           if (!blocking)
>               return -EAGAIN;
>       } else {
>          spin_lock_irqrestore()
>          break;
>       }
> }
> 
> 
I'm afraid we would need to re-acquire the lock before modifying 
ssif_bmc->is_singlepart_read and ssif_bmc->response_in_progress below.

>> +       }
>> +
>> +       /*
>> +        * Check the response data length from userspace to determine the type
>> +        * of the response message whether it is single-part or multi-part.
>> +        */
>> +       ssif_bmc->is_singlepart_read =
>> +               (ssif_msg_len(&ssif_bmc->response) <= (MAX_PAYLOAD_PER_TRANSACTION + 1)) ?
>> +               true : false; /* 1: byte of length */
> 
> I don't follow the 1: byte of length comment, what is it telling me?
> 
> The ternary operator is a bit messy here, I'd go for a good old if statement.
> 
The comment indeed does not provide any info here. Will change back to 
if else statement and add more meaningful comment if necessary in next 
version.

>> +
>> +       ssif_bmc->response_in_progress = true;
>> +       spin_unlock_irqrestore(&ssif_bmc->lock, flags);
>> +
>> +       return 0;
>> +}
> 
>> +/* Handle SSIF message that will be sent to user */
>> +static ssize_t ssif_bmc_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>> +{
>> +       struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(file);
>> +       struct ssif_msg msg;
>> +       unsigned long flags;
>> +       ssize_t ret;
>> +
>> +       mutex_lock(&ssif_bmc->file_mutex);
> 
> ->file_mutex is protecting the device against more than one user of
> the character device? Can you enforce that in open() instead?
> 

The current use is to serialize access among read()/write()/poll().

About enforcing open() to return -EBUSY to protect the device against 
more than one user, we can either implement follow example of 
drivers/char/ipmi/kcs_bmc.c OR drivers/char/ipmi/bt-bmc.c

But I'm still wonder what should be better between atomic_t open_count 
(bt_bmc.c) or simply reuse the file_mutex similar with kcs_bmc.c.

>> +
>> +       ret = receive_ssif_bmc_request(ssif_bmc, file->f_flags & O_NONBLOCK);
>> +       if (ret < 0)
>> +               goto out;
>> +
>> +       spin_lock_irqsave(&ssif_bmc->lock, flags);
>> +       count = min_t(ssize_t, count, ssif_msg_len(&ssif_bmc->request));
> 
> count is user controlled, so I assume ssif_msg_len will always be less
> than or equal to struct ssif_msg?
> 

The size of struct ssif_msg is 255 bytes, and the ssif_msg_len() should 
always return less than this number unless the ssif_msg->len is wrong 
and exceeded the size of struct ssif_msg.

For safe I think it should be changed to the min among count, 
sizeof(struct ssif_msg), and return value of 
ssif_msg_len(&ssif_bmc->request).
ie:
count = min_t(ssize_t, count, min_t(ssize_t, sizeof(struct ssif_msg), 
ssif_msg_len(&ssif_bmc->request));

>> +       memcpy(&msg, &ssif_bmc->request, count);
>> +       ssif_bmc->request_available = false;
>> +       spin_unlock_irqrestore(&ssif_bmc->lock, flags);
>> +
>> +       ret = copy_to_user(buf, &msg, count);
>> +out:
>> +       mutex_unlock(&ssif_bmc->file_mutex);
>> +
>> +       return (ret < 0) ? ret : count;
>> +}
>> +
>> +/* Handle SSIF message that is written by user */
>> +static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t count,
>> +                             loff_t *ppos)
>> +{
>> +       struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(file);
>> +       struct ssif_msg msg;
>> +       unsigned long flags;
>> +       ssize_t ret;
>> +
>> +       if (count > sizeof(struct ssif_msg))
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&ssif_bmc->file_mutex);
>> +
>> +       ret = copy_from_user(&msg, buf, count);
>> +       if (ret)
>> +               goto out;
>> +
>> +       spin_lock_irqsave(&ssif_bmc->lock, flags);
>> +       if (count >= ssif_msg_len(&ssif_bmc->response))
> 
> Is that test correct?
> 
As the "if (count > sizeof(struct ssif_msg))" above ensure the data will 
not exceeded the size of buffer, ie: sizeof ssif_msg, we can now to make 
sure the actually data size to agree with ssif_msg->len, ie: the return 
of ssif_msg_len().

But as this test looked "not easy to read" so I think I will fix this to:

    if (count < ssif_msg_len(&ssif_bmc->response))
         ret = -EINVAL;
    else
         memcpy(...);

Hope this way made it easier to read.

>> +               memcpy(&ssif_bmc->response, &msg, count);
>> +       else
>> +               ret = -EINVAL;
>> +       spin_unlock_irqrestore(&ssif_bmc->lock, flags);
>> +
>> +       if (ret)
>> +               goto out;
>> +
>> +       ret = send_ssif_bmc_response(ssif_bmc, file->f_flags & O_NONBLOCK);
>> +       if (!ret && ssif_bmc->set_ssif_bmc_status)
>> +               ssif_bmc->set_ssif_bmc_status(ssif_bmc, SSIF_BMC_READY);
>> +out:
>> +       mutex_unlock(&ssif_bmc->file_mutex);
>> +
>> +       return (ret < 0) ? ret : count;
>> +}
>> +
>> +static long ssif_bmc_ioctl(struct file *file, unsigned int cmd, unsigned long param)
>> +{
> 
> If you're not using this I suspect you should omit the callback.
> 
Will remove this in next version

>> +       return 0;
>> +}
>> +
>> +static unsigned int ssif_bmc_poll(struct file *file, poll_table *wait)
>> +{
>> +       struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(file);
>> +       unsigned int mask = 0;
>> +
>> +       mutex_lock(&ssif_bmc->file_mutex);
>> +       poll_wait(file, &ssif_bmc->wait_queue, wait);
>> +
>> +       /*
>> +        * The request message is now available so userspace application can
>> +        * get the request
>> +        */
>> +       if (ssif_bmc->request_available)
>> +               mask |= POLLIN;
>> +
>> +       mutex_unlock(&ssif_bmc->file_mutex);
>> +       return mask;
>> +}
>> +
>> +/*
>> + * System calls to device interface for user apps
>> + */
>> +static const struct file_operations ssif_bmc_fops = {
>> +       .owner          = THIS_MODULE,
>> +       .read           = ssif_bmc_read,
>> +       .write          = ssif_bmc_write,
>> +       .poll           = ssif_bmc_poll,
>> +       .unlocked_ioctl = ssif_bmc_ioctl,
>> +};
>> +
>> +/* Called with ssif_bmc->lock held. */
>> +static int handle_request(struct ssif_bmc_ctx *ssif_bmc)
> 
> Could return void.
> 
Will do in next version

>> +{
>> +       if (ssif_bmc->set_ssif_bmc_status)
>> +               ssif_bmc->set_ssif_bmc_status(ssif_bmc, SSIF_BMC_BUSY);
>> +
>> +       /* Request message is available to process */
>> +       ssif_bmc->request_available = true;
>> +       /*
>> +        * This is the new READ request.
>> +        * Clear the response buffer of the previous transaction
>> +        */
>> +       memset(&ssif_bmc->response, 0, sizeof(struct ssif_msg));
>> +       wake_up_all(&ssif_bmc->wait_queue);
>> +       return 0;
>> +}
>> +
>> +/* Called with ssif_bmc->lock held. */
>> +static int complete_response(struct ssif_bmc_ctx *ssif_bmc)
> 
> Could return void.
>
Will do in next version

>> +{
>> +       /* Invalidate response in buffer to denote it having been sent. */
>> +       ssif_bmc->response.len = 0;
>> +       ssif_bmc->response_in_progress = false;
>> +       ssif_bmc->nbytes_processed = 0;
>> +       ssif_bmc->remain_len = 0;
>> +       memset(&ssif_bmc->response_buf, 0, MAX_PAYLOAD_PER_TRANSACTION);
>> +       wake_up_all(&ssif_bmc->wait_queue);
>> +       return 0;
>> +}
>> +
>> +static void set_multipart_response_buffer(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
>> +{
> 
>> +       default:
>> +               /* Do not expect to go to this case */
>> +               pr_err("Error: Unexpected SMBus command received 0x%x\n", ssif_bmc->smbus_cmd);
> 
> Use dev_err if you can, so the message is associated with the device.
> 

Will try to use dev_err() in next version

>> +               break;
>> +       }
>> +
>> +       ssif_bmc->nbytes_processed += response_len;
>> +}
>> +

