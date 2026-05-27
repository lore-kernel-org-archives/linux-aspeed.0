Return-Path: <linux-aspeed+bounces-4137-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEB7CD5BDE
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 03:19:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQFGq11wTz2yTH;
	Wed, 27 May 2026 13:19:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779851987;
	cv=none; b=mKhhqz3ZxJgtl1OQ8JqP8duyGMhMUyDAnrJeD+I4Rprw1z5xUNAAMHbRhj0WSgPir7sLjaRX2lwrdGuQKPVomQe4wk3ArRNM/hkWCH25yyPllhYcV8WktYX03R4/oNqoXMNMx7emlZV5cveTurQQo/eNQv5A+DZwdOAzHZBLSlmvzWar7CL0XsrWbys3SkNfK4GZQnRCy2/HMZbZYsSxbAAZhOoGRTnK5SgPkq/PNXGJVi/Emlw0GEyabYvsJmrYY2AMQ9uHh2fY++2C8yFaMscbv7rtleX2Pw1o2mXwETLzSnCP8pSiB697ydLQ0dEu/MQDsf/4EQpja6MNZ88m9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779851987; c=relaxed/relaxed;
	bh=RS3tEt0ZcmVbPx/5QD48l1DIJzlT1nMDifXpMkbDJ1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGEFGegxX0oRZTI5cSZeOcOJXG7mIvmNg9RdNWjPVN4PnKiUpxwaQhxGliJQ379IiAqXA5OPs27iY97D2dnkBearSMhWAMQl5xgfnUGrzYiVbtAsEf/r2hIjCvPFGhYZA+4FmyYzobgcFwH2YpsxjcE6IdJ9k26feLqVn1dn9Ur35AyHtrKn4fwoupkbiBzreX1TM6s3CvvA/jSQlzatTYSOFGPNJ/i2ZFLUOjVzvuxJ89ePaZ+yTfdlssGzvP3Liaj5fW1IK0M1AXzod2UT+dgqVBjG3/xD1lrx9mDzG91WpEBbKgb1ogDgdAwsJHpiDsLJl5MmdrA85hVBLifsTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=APLx//61; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=APLx//61;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQFGp3MgDz2xtC
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 13:19:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779851985;
	bh=RS3tEt0ZcmVbPx/5QD48l1DIJzlT1nMDifXpMkbDJ1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=APLx//61j60ZOooYHs9WVkywLOkinvyZktLXiy4xpewiu2D6IRWK3Wia4FMcaTNXB
	 VI+e3htamPSpVAx/jBzoDnDD7ieUDk1tN0OsmdNLt8jGlsrgO1DFmGDlleqCB6R/kU
	 rtsRe9aMpwVxvdo5ytugqpJQNv8fFvsOPcKn4o29dJqMTFKLZ1PEYuO19Tw3Nvs4wA
	 ZiyG7EUje5pUp690jx8IoJdcF162YOxL/2Ur3D+Ch9gQqPX/1jsaA9fJ3nUrqQgxnD
	 TvD55DvvahqpvmWl/Kw/ZQqnVLejllAn6Mg49Z6dTZm5jqLgQ+oJcUi7Le0dQoqZhR
	 rcnHZdEuTocpA==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7588D6001B;
	Wed, 27 May 2026 11:19:45 +0800 (AWST)
Message-ID: <1a6ee5e082756931f1c15677ad3f5ba0fa5bbb6a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: sanmiguel: Add IOEXP interrupt
 pin settings
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, Potin Lai
	 <potin.lai@quantatw.com>
Date: Wed, 27 May 2026 12:49:45 +0930
In-Reply-To: <20260523-potin-update-sanmiguel-dts-20260522-v1-1-169f5fceb5f9@quantatw.com>
References: 
	<20260523-potin-update-sanmiguel-dts-20260522-v1-0-169f5fceb5f9@quantatw.com>
	 <20260523-potin-update-sanmiguel-dts-20260522-v1-1-169f5fceb5f9@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Potin,

On Sat, 2026-05-23 at 10:28 +0800, Potin Lai wrote:
> Kernel dmesg reports IRQ #44 being disabled due to unhandled
> interrupts from multiple PCA953x IO expanders:
>=20
> ```
> [ 447.047861] irq 44: nobody cared (try booting with the "irqpoll" option=
)
> [ 447.063124] handlers:
> [ 447.068176] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.087268] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.106344] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.125421] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.144513] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.163587] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.182663] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.201756] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc31=
0>] pca953x_irq_handler
> [ 447.220837] Disabling IRQ #44
> ```

I've applied this, but in the future can you please rather indent log
snippets rather than use markdown code-block fences?

Cheers,

Andrew

