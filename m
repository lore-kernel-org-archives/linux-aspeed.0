Return-Path: <linux-aspeed+bounces-149-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05881D6E2B2
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 Nov 2024 04:43:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XtTJV1n86z2xvh;
	Wed, 20 Nov 2024 15:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732077802;
	cv=none; b=YmnDNDjxXztJNMGyyuXNeYVIuZVzPwNCLQRCcgGWCJKE4himGhImsxbPcHNyzAjNfjQUofLKgdk9JiLTt4VIUt/q0NK40DV1w4BFi7rLF1y4j4EIcn14UDSIpGXOWEXB3CWVpRgxbvsY+s4j6l5dLWAQBIvU3iSM4MXVAnB3LA+kvQxBS+Q/3mcTDq/36X9dXw2TA2BcQtkpiEVVoDj7T0A1oXdCwXjmd8+A1bMyhNh9a87jE9fktioRUxK9tZvF1DVeFIKuSRdEa10TqBI6eMBMwDCvANADdkp46kULdcb577vigl7IAvDeceP/NJ8kIoIJqnSImWkXM+5O6fyDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732077802; c=relaxed/relaxed;
	bh=22Pb0xyAbFBgiBPWl6KARML2Z6bek2t466sfMUumy1I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMERoIeWeGHKFqCVfGpJKYVNAlMVLLWjszzVspAeDTCMwK6CpRMrjiLg1X1vt8Wv3NdkqBVfflaGmMBGtN1+SoL5Rcq4OGSgJY8flL4oYblnLuux7CiWLwSip2+rS/ECNALSFeoGnMhRV5QFYA1N8WbgoilXODK7Q5ia4Bz2fzUmWX8KOzhgpa9lxFp64nRQAdE0X78RMgvpHeyVP0BbbPkjdJYtBMXaiRQUO/yLIUINNaH8O4UdUypHVhvYnGrynWTcBDTBT0FiiHgJw7biGYKkeG7D4pJ8GDIslQEG5f+MApm0cj9QFvxu2y+9mBuWtZCRSa7IVBUNpsBX+KuZtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LDURYvZ9; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LDURYvZ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XtTJS1ZPfz2xjv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 15:43:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732077797;
	bh=22Pb0xyAbFBgiBPWl6KARML2Z6bek2t466sfMUumy1I=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LDURYvZ9kRvVIXv7xCSSyCxOM5f3lAAm1Q4B/2z3fwKU4kB2xIPyNVb1VgLSOpML1
	 D3RrL9Rp3w6bFh05vQRMeclYwfWjWSzKc4xvEw+Vc0ZDX8gdnlK7jaqSpOBvTFnrBW
	 GH5BRw9Eh/CG7U4rpzFRlzEu4lVSBQgZjjlxwgjONXKXNZu82oiHQ3xvU400zrTHBk
	 KGZj2FIcwA2AYSrcP1AeUm3KMIh8GRLcUhA6t6p/7oD4xMmCh5xzj/F9FZbMNxLC7I
	 tkIl4ekrG0ai4V/jKlANbGJtp+Cj7Mh+miwIpfnMCwPq6ed12BqiCvH7++7H3YgiiE
	 5+Bl7XNiRKjoQ==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 398DA66403;
	Wed, 20 Nov 2024 12:43:12 +0800 (AWST)
Message-ID: <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire
 control
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, joel@jms.id.au, 
	f.fainelli@gmail.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2024 15:13:11 +1030
In-Reply-To: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Tue, 2024-11-19 at 17:51 +0800, Jacky Chou wrote:
> When the command bus is sometimes busy, it may cause the command is
> not
> arrived to MDIO controller immediately. On software, the driver
> issues a
> write command to the command bus does not wait for command complete
> and
> it returned back to code immediately. But a read command will wait
> for
> the data back, once a read command was back indicates the previous
> write
> command had arrived to controller.
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller to avoid polling unexpected
> timeout.

Why use the explicit dummy read rather than adjust the poll interval or
duration? I still don't think that's been adequately explained given
the hardware-clear of the fire bit on completion, which is what we're
polling for.

Andrew

