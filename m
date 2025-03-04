Return-Path: <linux-aspeed+bounces-936-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858D4C021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 21:55:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6qH86vfZz307V;
	Wed,  5 Mar 2025 08:55:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.12.242.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741125316;
	cv=none; b=CNmLQJqpARXor9vK90aPOTE4ktb66eOUk7TAaEwPdIywv/PEw7eORuMjBnH4p49MTku2aCqxlnMSRyrlo4hxkhEUQqowlnpEcJADlxnvElaPctvODt9rZPqW3uTXs269mufLLGZcXybmo6tIzpKwfG+99KOkk/Td13082cbUSXpMFEoZDYcueeTuOMTOnTjunp5L3FMxqYdn7gidWYOPqK+1WkFMj3vR11oshNJDgfYNGdkfkUCpqvp/Bx5s5hwYVauToOtObf2C53H6/Fp3xHRC3TKEdCgCzRpbpcf09cfT6fauPYtqP82uhqpWZaDE7N9JvYGdW0CzY/V6l+t+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741125316; c=relaxed/relaxed;
	bh=K+h7jsWHv3eIxLPH5dNajezN+xQFTDwe/w8/eZdR268=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cakA4AzesxbtZYoxl7vDZ2S8I56fmAOBM6QGqu8ZmMpGtZ1j/wVGAxrTE5wJ6nUtg375v8fcD1B80YRWcLPNxISDWjPIAc3Gn91s1E+3svjqvaegENVgYyAJQgdHbGfbd8ZCgB37TfqpdmBVw5IqQgF7GT9YFMMNq2vW6KXyTsjOxr47inFlbX6/Lw23EjOkQIAAZ1QZHUQ/fN+wbrSn84JBM7C7AJUxkuoYngXKkEFeHLFKnJEz5HF3g5Yw0g81Qyy7VXngdgz1vFRxyQos4wqyZ6brvndlhQ/DSIwzVpKjfESWGZAMVDOfMWuVlsFa5BMA7CEsNl6u0SbJY+W3aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=F/htZXuH; dkim-atps=neutral; spf=pass (client-ip=80.12.242.78; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org) smtp.mailfrom=wanadoo.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=F/htZXuH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=80.12.242.78; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 1963 seconds by postgrey-1.37 at boromir; Wed, 05 Mar 2025 08:55:13 AEDT
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6qH504XWz2xy7
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 08:55:11 +1100 (AEDT)
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pZhEtjoYlf1j1pZhItMWBa; Tue, 04 Mar 2025 22:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741123273;
	bh=K+h7jsWHv3eIxLPH5dNajezN+xQFTDwe/w8/eZdR268=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F/htZXuHwOLqrOg37Ie4xDkEu5dSoXycvKds+QJgKpHM4TF1OfVT4PgIZuJDeGsrB
	 7qx9+ZmsUoXQ9CxklHemGcceTvS3H7LKNkR9LpBbJPyxeMj4+OhOJVX/dIbM51l0ea
	 mSFuiORCumZyYWbbq5vwhFzOK/bETgw1Bhn9ORtyVf6YLnqItZ94mJAK5qh0IDCT51
	 /Tw545tJjZPj9yLKoj7O2JntYzLwJiLtZvYykbYpMVGXLVw8Lt4yzIapdyNsw6aXKJ
	 6BHl6lQXZd3Ia8praMr/qD7YfmQ0mg6MIWWvafegftXVEwL42f7yq+x1VOGvchNrqC
	 ggVLi8D6df4mQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 04 Mar 2025 22:21:13 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7ef88ec2-24a5-4aa7-a601-d605a12768ba@wanadoo.fr>
Date: Tue, 4 Mar 2025 22:20:59 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-4-kevin_chen@aspeedtech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250304104434.481429-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/03/2025 à 11:44, Kevin Chen a écrit :
> Add LPC PCC controller driver to support POST code capture.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Hi,

> +	init_waitqueue_head(&pcc->wq);
> +
> +	pcc->mdev_id = ida_alloc(&aspeed_pcc_ida, GFP_KERNEL);

Missing ida_free() in therror handling path and in the rmove function?

> +	if (pcc->mdev_id < 0) {
> +		dev_err(dev, "Couldn't allocate ID\n");
> +		return pcc->mdev_id;
> +	}
> +
> +	pcc->mdev.parent = dev;
> +	pcc->mdev.minor = MISC_DYNAMIC_MINOR;
> +	pcc->mdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
> +					pcc->mdev_id);
> +	pcc->mdev.fops = &pcc_fops;
> +	rc = misc_register(&pcc->mdev);
> +	if (rc) {
> +		dev_err(dev, "Couldn't register misc device\n");
> +		goto err_free_kfifo;
> +	}
> +
> +	rc = aspeed_pcc_enable(pcc, dev);
> +	if (rc) {
> +		dev_err(dev, "Couldn't enable PCC\n");
> +		goto err_dereg_mdev;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, pcc);
> +
> +	return 0;
> +
> +err_dereg_mdev:
> +	misc_deregister(&pcc->mdev);
> +
> +err_free_kfifo:
> +	kfifo_free(&pcc->fifo);
> +
> +	return rc;
> +}
> +
> +static void aspeed_pcc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct aspeed_pcc_ctrl *pcc = dev_get_drvdata(dev);
> +
> +	kfifo_free(&pcc->fifo);
> +	misc_deregister(&pcc->mdev);
> +}
> +
> +static const struct of_device_id aspeed_pcc_table[] = {
> +	{ .compatible = "aspeed,ast2600-lpc-pcc" },
> +	{ },

Unneeded trailing comma after a terminator.

> +};
> +
> +static struct platform_driver aspeed_pcc_driver = {
> +	.driver = {
> +		.name = "aspeed-pcc",
> +		.of_match_table = aspeed_pcc_table,
> +	},
> +	.probe = aspeed_pcc_probe,
> +	.remove = aspeed_pcc_remove,
> +};

...

CJ

