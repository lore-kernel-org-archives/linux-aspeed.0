Return-Path: <linux-aspeed+bounces-1637-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F0C83F03
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 15:34:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYd3v4T2Yz3bNt;
	Sat,  5 Jul 2025 01:34:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751643291;
	cv=none; b=mIsfA7qO8JLD21njm3bxj2ZroBGvpCyDCWuS35rdMmq43GUcFXMEwRvWLcYYOcfmkl6YcVMBKI9IEgOrIGYY6R4o9MUmu0gkPTfkqdm1tSubpGH2TrvbJDE9YU1R/sRi99oDXosa47sBcPJ1c1KHl5b7DObxpLuYhq8rwWKe+LKhUEFyEI76Q1EUnn9WYZunJD3zD9KluPC0MlSIcP1njcXGmsLyFo+mPDCSb7CC9AiAtNfini6xg7+uMxfJmnB1l6veBJgVyVAFB2rgwR7F7TBzQgVe/GfT0sm26a4oQL8iWfR1DsuajqOwSX/cGdf5NBl53RyeP8KaA2oR9xPDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751643291; c=relaxed/relaxed;
	bh=SIKVu0G3IqL/5nXUeA5vN9eSOQZPoQd570/KkcbAJ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUb7cmw2fu9KHklIy4Eq+rpl+7K2e506pvNPalMdfgy0i4+oGe7NIGg+YtJqngCUhnNhuFtUvZM77bO0R62MEU3a0PWUwSS+9vcm3un8GJ3PGN5CwrDSxJ8iFQk4QqSfhYlJoLLHnrUly+4hi8BVR+AOfQHwRl6ao7cr00c5bgPWj6YgEdAEhAduCn0+94ecri1MneRnVPHJfkYfMI26LumkEgIIhU3n64zrc+lMysJ1OKIZzQ50VFLDpydXVJjP9NJT+9gR5vX7WkN972eWL8VEc1P+Uz7v4cR3Lyl5DSuykmjqJ+V/c2Gk5kIp5ZrRqyeS0AodquSgDnv00bVSsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDFc+xTh; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QiQPeqke; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDFc+xTh; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QiQPeqke; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDFc+xTh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QiQPeqke;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VDFc+xTh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QiQPeqke;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYd3t317zz30Pn
	for <linux-aspeed@lists.ozlabs.org>; Sat,  5 Jul 2025 01:34:49 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9446C1F394;
	Fri,  4 Jul 2025 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751643286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIKVu0G3IqL/5nXUeA5vN9eSOQZPoQd570/KkcbAJ4g=;
	b=VDFc+xThyj/w9oOlp62W1Fc+/oYlUFtEEihGbjvqxX/ZRAZ92fccCVfOUCfd3MnQXoY9l9
	kDGoPS/Q/BLxy/sKYaswZbEUeK44CjQaAXajp/9He8MSgTDFpgbJZ1rIzHvCx11DreW21M
	CfTek6niAl4iv4hMUwa3utAQoFDkzV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751643286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIKVu0G3IqL/5nXUeA5vN9eSOQZPoQd570/KkcbAJ4g=;
	b=QiQPeqkeovOdAE+fYvTOqNGMKtQ9gJSWR5KsMb8wbbYCohePkgZTBFDzHO7LvqfQpS3zQa
	JoGvMY1XtMWDRyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751643286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIKVu0G3IqL/5nXUeA5vN9eSOQZPoQd570/KkcbAJ4g=;
	b=VDFc+xThyj/w9oOlp62W1Fc+/oYlUFtEEihGbjvqxX/ZRAZ92fccCVfOUCfd3MnQXoY9l9
	kDGoPS/Q/BLxy/sKYaswZbEUeK44CjQaAXajp/9He8MSgTDFpgbJZ1rIzHvCx11DreW21M
	CfTek6niAl4iv4hMUwa3utAQoFDkzV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751643286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIKVu0G3IqL/5nXUeA5vN9eSOQZPoQd570/KkcbAJ4g=;
	b=QiQPeqkeovOdAE+fYvTOqNGMKtQ9gJSWR5KsMb8wbbYCohePkgZTBFDzHO7LvqfQpS3zQa
	JoGvMY1XtMWDRyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D56E13757;
	Fri,  4 Jul 2025 15:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SYKTBJb0Z2i6DAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 04 Jul 2025 15:34:46 +0000
Date: Fri, 4 Jul 2025 17:34:43 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>,
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] soc: aspeed: lpc-snoop: Rearrange channel
 paths
Message-ID: <20250704173443.3436f535@endymion>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-6-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	<20250616-aspeed-lpc-snoop-fixes-v2-6-3cdd59c934d3@codeconstruct.com.au>
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
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,jms.id.au,gmail.com,9elements.com,yahoo.com,linux.ibm.com,google.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Mon, 16 Jun 2025 22:43:43 +0930, Andrew Jeffery wrote:
> Order assignments such that tests for conditions not involving resource
> acquisition are ordered before those testing acquired resources, and
> order managed resource acquisition before unmanaged where possible. This
> way we minimise the amount of manual cleanup required.
> 
> In the process, improve readability of the code by introducing a channel
> pointer that takes the place of the repeated object lookups.
> 
> Acked-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 ++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
> (...)
> @@ -238,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  		goto err_misc_deregister;
>  	}
>  
> +	/* Enable LPC snoop channel at requested port */
>  	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
>  	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
>  			   lpc_port << snpwadr_shift);

This duplicates a comment which is already present in the driver a few
lines before.

This duplicated comment gets cleaned up later in patch 10/10 (soc:
aspeed: lpc-snoop: Lift channel config to const structs).

-- 
Jean Delvare
SUSE L3 Support

