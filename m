Return-Path: <linux-aspeed+bounces-1638-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190D9C83F03
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 16:23:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYf8Z4BT2z30gC;
	Sat,  5 Jul 2025 02:23:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751646238;
	cv=none; b=gsS30bVigyBPP/raXA4205ypKo92i+e+aCo1Nw7MdvoNVQ6FheM5TaCNlmAXHr9p/Q8CwOMgDr8KcPHhHhL+aEAQjiSdHphm12FHBompo/mYCMfJrFi95u7MF9k43aFCAcmi/Abpig5kFv5OpunqT0+eo3J/Ug4KHRpC6UivPNPSPE1s7RKRh55oeWhWHQ5OYHFFl7pT0DobtzzqAn6L/XTKQ7/sEVJc9o33KLM1Q7U2rvGJJQIo8lJYKv+AnpUTcjXWvNMFhY4XrH7mIOeTcNeD8uZAzJNX6yQ9u2I/I4Q7B29FTr+ceV2xXxJH5abWiNPbpO2wAIVMHEcSwqbP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751646238; c=relaxed/relaxed;
	bh=QnCd8EhWi608gG2ZJYlh4eX8dcVJgRAAdrIHdUvyEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM0jGpYMNVU3FirbgbJ7Sxb7jbV0lIQgFuVTe7C7MeXhL3wMaDEmIVvIwVRquz8piL9CtC3TFM2pKerXguNu+Jk0Hku7gxCHFGbJrsNuUs/snTR7xhjO6hIdXtZOBS4Cj+9PXqHQwrG3U4Km2Ve1YPWAuxLrFfAkbqgBtaPdWRNG5StuRl/CEvRtl0ycbPTaSPcxTdf1Jr6qAHC4XJ5qjUxHyCEZ90FlxgCIAxEF9QbF2pTuTKDQffU1FNsOBD5BY5zIMrS9cYA/op1PgV08Sdo3Ei95a0nL61fcujDz116hNMNZEXKBdwh1koopHSyYsw3u29zNpDRmISIFkcEyoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L2gR8tuP; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2ovIm12+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L2gR8tuP; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2ovIm12+; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L2gR8tuP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2ovIm12+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L2gR8tuP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2ovIm12+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYf8Y0fHLz30Wn
	for <linux-aspeed@lists.ozlabs.org>; Sat,  5 Jul 2025 02:23:56 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA2A51F38A;
	Fri,  4 Jul 2025 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751646233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnCd8EhWi608gG2ZJYlh4eX8dcVJgRAAdrIHdUvyEVw=;
	b=L2gR8tuP/PGpICezWU6I/FHdzfdVJ014+mXt7VCUxfIQQGuLHGkju0of77fIkhWtrXhLlv
	6B6Nnw61wPYIIbP4VKNpFWgCSNIN7tPBAOsVBDPKwM6gVGRueQs4W3TQ4dj3xYzz/Imi/M
	8K8tJAs/q55YfzyCxE5lnc279+Ynnyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751646233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnCd8EhWi608gG2ZJYlh4eX8dcVJgRAAdrIHdUvyEVw=;
	b=2ovIm12+Lw1AIzV5K/Ddziql1f/EX0Vn9Xt4Lt+ZdAxmlKIPcDAKDV1CHX+WjgoQJFWuV6
	kQc3a1yAdZFyzRBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751646233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnCd8EhWi608gG2ZJYlh4eX8dcVJgRAAdrIHdUvyEVw=;
	b=L2gR8tuP/PGpICezWU6I/FHdzfdVJ014+mXt7VCUxfIQQGuLHGkju0of77fIkhWtrXhLlv
	6B6Nnw61wPYIIbP4VKNpFWgCSNIN7tPBAOsVBDPKwM6gVGRueQs4W3TQ4dj3xYzz/Imi/M
	8K8tJAs/q55YfzyCxE5lnc279+Ynnyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751646233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnCd8EhWi608gG2ZJYlh4eX8dcVJgRAAdrIHdUvyEVw=;
	b=2ovIm12+Lw1AIzV5K/Ddziql1f/EX0Vn9Xt4Lt+ZdAxmlKIPcDAKDV1CHX+WjgoQJFWuV6
	kQc3a1yAdZFyzRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A4613757;
	Fri,  4 Jul 2025 16:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kke6DxkAaGhNGgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 04 Jul 2025 16:23:53 +0000
Date: Fri, 4 Jul 2025 18:23:48 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>,
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] soc: aspeed: lpc-snoop: Lift channel config to
 const structs
Message-ID: <20250704182348.53808e0f@endymion>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-10-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	<20250616-aspeed-lpc-snoop-fixes-v2-10-3cdd59c934d3@codeconstruct.com.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,jms.id.au,gmail.com,9elements.com,yahoo.com,linux.ibm.com,google.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi Andrew,

On Mon, 16 Jun 2025 22:43:47 +0930, Andrew Jeffery wrote:
> The shifts and masks for each channel are defined by hardware and
> are not something that changes at runtime. Accordingly, describe the
> information in an array of const structs and associate elements with
> each channel instance, removing the need for the switch and handling of
> its default case.

I like this.

Note that technically, the removal of the default case in the switch
was already possible since patch 06/10 (soc: aspeed: lpc-snoop:
Constrain parameters in channel paths).

> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 100 +++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 9f88c5471b1b6d85f6d9e1970240f3d1904d166c..2d97b8d5fb429e215c321c9c2ee3fa35d39f8618 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -63,7 +63,16 @@ enum aspeed_lpc_snoop_index {
>  	ASPEED_LPC_SNOOP_INDEX_MAX = ASPEED_LPC_SNOOP_INDEX_1,
>  };
>  
> +struct aspeed_lpc_snoop_channel_cfg {
> +	enum aspeed_lpc_snoop_index index;
> +	u32 hicr5_en;
> +	u32 snpwadr_mask;
> +	u32 snpwadr_shift;
> +	u32 hicrb_en;
> +};
> +
>  struct aspeed_lpc_snoop_channel {
> +	const struct aspeed_lpc_snoop_channel_cfg *cfg;
>  	bool enabled;
>  	struct kfifo		fifo;
>  	wait_queue_head_t	wq;
> @@ -77,6 +86,23 @@ struct aspeed_lpc_snoop {
>  	struct aspeed_lpc_snoop_channel chan[ASPEED_LPC_SNOOP_INDEX_MAX + 1];
>  };
>  
> +static const struct aspeed_lpc_snoop_channel_cfg channel_cfgs[ASPEED_LPC_SNOOP_INDEX_MAX + 1] = {
> +	{
> +		.index = ASPEED_LPC_SNOOP_INDEX_0,
> +		.hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
> +		.snpwadr_mask = SNPWADR_CH0_MASK,
> +		.snpwadr_shift = SNPWADR_CH0_SHIFT,
> +		.hicrb_en = HICRB_ENSNP0D,
> +	},
> +	{
> +		.index = ASPEED_LPC_SNOOP_INDEX_1,
> +		.hicr5_en = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
> +		.snpwadr_mask = SNPWADR_CH1_MASK,
> +		.snpwadr_shift = SNPWADR_CH1_SHIFT,
> +		.hicrb_en = HICRB_ENSNP1D,
> +	},
> +};
> +
>  static struct aspeed_lpc_snoop_channel *snoop_file_to_chan(struct file *file)
>  {
>  	return container_of(file->private_data,
> @@ -189,28 +215,27 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
>  }
>  
>  __attribute__((nonnull))
> -static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
> -				   struct device *dev,
> -				   enum aspeed_lpc_snoop_index index, u16 lpc_port)
> +static int aspeed_lpc_enable_snoop(struct device *dev,
> +				    struct aspeed_lpc_snoop *lpc_snoop,
> +				    struct aspeed_lpc_snoop_channel *channel,
> +				    const struct aspeed_lpc_snoop_channel_cfg *cfg,
> +				    u16 lpc_port)
>  {

I'm confused by this new calling convention. With lpc_snoop and index,
you could already retrieve the aspeed_lpc_snoop_channel struct and the
aspeed_lpc_snoop_channel_cfg struct. I can't see the benefit of the
change. It even forces you to add an index field to struct
aspeed_lpc_snoop_channel_cfg, which would otherwise not be needed.

If you prefer to pass cfg instead of index as a parameter, that does
not imply passing channel too. You can get the index from the cfg (if
you decide to keep it in that struct), and then the channel from index.

Or you could even pass only the channel (to be consistent with
aspeed_lpc_disable_snoop), if you set channel->cfg before calling this
function. Again this implies keeping index in struct
aspeed_lpc_snoop_channel_cfg.

>  	const struct aspeed_lpc_snoop_model_data *model_data;
> -	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
> -	struct aspeed_lpc_snoop_channel *channel;
>  	int rc = 0;
>  
> -	channel = &lpc_snoop->chan[index];
> -
>  	if (WARN_ON(channel->enabled))
>  		return -EBUSY;
>  
>  	init_waitqueue_head(&channel->wq);
>  
> +	channel->cfg = cfg;
>  	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	channel->miscdev.fops = &snoop_fops;
>  	channel->miscdev.parent = dev;
>  
>  	channel->miscdev.name =
> -		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, index);
> +		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, cfg->index);
>  	if (!channel->miscdev.name)
>  		return -ENOMEM;
>  
> @@ -223,39 +248,18 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  		goto err_free_fifo;
>  
>  	/* Enable LPC snoop channel at requested port */
> -	switch (index) {
> -	case 0:
> -		hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W;
> -		snpwadr_mask = SNPWADR_CH0_MASK;
> -		snpwadr_shift = SNPWADR_CH0_SHIFT;
> -		hicrb_en = HICRB_ENSNP0D;
> -		break;
> -	case 1:
> -		hicr5_en = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W;
> -		snpwadr_mask = SNPWADR_CH1_MASK;
> -		snpwadr_shift = SNPWADR_CH1_SHIFT;
> -		hicrb_en = HICRB_ENSNP1D;
> -		break;
> -	default:
> -		rc = -EINVAL;
> -		goto err_misc_deregister;
> -	}
> -
> -	/* Enable LPC snoop channel at requested port */
> -	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
> -	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
> -			   lpc_port << snpwadr_shift);
> +	regmap_set_bits(lpc_snoop->regmap, HICR5, cfg->hicr5_en);
> +	regmap_update_bits(lpc_snoop->regmap, SNPWADR, cfg->snpwadr_mask,
> +		lpc_port << cfg->snpwadr_shift);

It is a good practice to align the second line on the opening
parenthesis of the first line (as was done originally).

>  
>  	model_data = of_device_get_match_data(dev);
>  	if (model_data && model_data->has_hicrb_ensnp)
> -		regmap_update_bits(lpc_snoop->regmap, HICRB, hicrb_en, hicrb_en);
> +		regmap_set_bits(lpc_snoop->regmap, HICRB, cfg->hicrb_en);
>  
>  	channel->enabled = true;
>  
>  	return 0;
>  
> -err_misc_deregister:
> -	misc_deregister(&channel->miscdev);
>  err_free_fifo:
>  	kfifo_free(&channel->fifo);
>  	return rc;
> @@ -263,30 +267,13 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  
>  __attribute__((nonnull))
>  static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
> -				     enum aspeed_lpc_snoop_index index)
> +				     struct aspeed_lpc_snoop_channel *channel)
>  {
> -	struct aspeed_lpc_snoop_channel *channel;
> -
> -	channel = &lpc_snoop->chan[index];
> -
>  	if (!channel->enabled)
>  		return;
>  
>  	/* Disable interrupts along with the device */
> -	switch (index) {
> -	case 0:
> -		regmap_update_bits(lpc_snoop->regmap, HICR5,
> -				   HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
> -				   0);
> -		break;
> -	case 1:
> -		regmap_update_bits(lpc_snoop->regmap, HICR5,
> -				   HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
> -				   0);
> -		break;
> -	default:
> -		return;
> -	}
> +	regmap_clear_bits(lpc_snoop->regmap, HICR5, channel->cfg->hicr5_en);
>  
>  	channel->enabled = false;
>  	/* Consider improving safety wrt concurrent reader(s) */
> @@ -299,8 +286,8 @@ static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
>  	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
>  
>  	/* Disable both snoop channels */
> -	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
> -	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
> +	aspeed_lpc_disable_snoop(lpc_snoop, &lpc_snoop->chan[0]);
> +	aspeed_lpc_disable_snoop(lpc_snoop, &lpc_snoop->chan[1]);
>  }
>  
>  static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
> @@ -339,6 +326,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	static_assert(ARRAY_SIZE(channel_cfgs) == ARRAY_SIZE(lpc_snoop->chan),
> +		"Broken implementation assumption regarding cfg count");

Both also need to be equal to ASPEED_LPC_SNOOP_INDEX_MAX + 1, right?
Otherwise the loop below would break. But it turns out that both arrays
are now declared that way, so it just has to be true. This makes me
believe that this static assert is no longer needed.

>  	for (idx = ASPEED_LPC_SNOOP_INDEX_0; idx <= ASPEED_LPC_SNOOP_INDEX_MAX; idx++) {
>  		u32 port;
>  
> @@ -346,7 +335,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
>  		if (rc)
>  			break;
>  
> -		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, idx, port);
> +		rc = aspeed_lpc_enable_snoop(dev, lpc_snoop, &lpc_snoop->chan[idx],
> +					     &channel_cfgs[idx], port);
>  		if (rc)
>  			goto cleanup_channels;
>  	}
> 


-- 
Jean Delvare
SUSE L3 Support

