Return-Path: <linux-aspeed+bounces-215-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D8E77180
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 05:28:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8dCz1rZ0z30gL;
	Fri, 13 Dec 2024 16:28:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734067711;
	cv=none; b=EPSwso+R1ODyzCHYFu2EIDhC1X2eT0GfLo9m/hcCwJ+rJMw+SLPLPWnh+8RhqM3tBvJr5ioLweewezcYp/0HFjv2e6GQjYcOiUQPZ16PvmUUa7htHyUp+EDok484fR8mcQOmYfgUarx5k/uJzHoFj9QFMPFlNr5HvwI2BbarobrHpX5sz2JMAvzhDDzaUlpNYInyWwUttY+4nQ0gv+dYgd1tRcmDlJwjiBEMcG6YuNIYkLR2CmS6MD08n2RU4NslpIoU2hImV2cUGINuyadJiYNXXptR0qXXl87qBvW6QSyPFl91tN5SuKhjq31cCR9aLjtypuxtVs3HRSqlYBAU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734067711; c=relaxed/relaxed;
	bh=nD0sOR12WYgd7zNnRDb+Fa3B5asY+3ux+m3WDu2HAKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EA/SRMVKcsBFF4TwCk4LWrg+teMjs9eyQwgEe5PQArQY+GJ3xaOX5dO2spyrhDUVeVgW2X3xHxq8WnRRpaQtaWsthOZkS+v4c6a3CvqyleDzNmnlhCtYflhX842Ff9u4EqLHKbGVFMQswrdGawV7fqiWept0pvEKecK9WmTuQeE/gdfpIXtTdMSN7XHmJhjwziFIIcjChRT1uTHHPlUAfR9uymaOcftbERQ60kboShtDPM1rmTSlp6en6ogD+Q1l9X8AxaEHdnVX8suxWUJiGvsMrAvloYsmB0sxLAPnhv214JpSwBF/HncvADboh46CQidbfiCmvjR9A3KY+I4Aww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RABT6iUr; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RABT6iUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8dCy3PL8z30g6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 16:28:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734067709;
	bh=nD0sOR12WYgd7zNnRDb+Fa3B5asY+3ux+m3WDu2HAKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RABT6iUrzTl2BIniPxxi7HRX7TTQnO84EHOkzY2A7mKbGGFTfQHSgCTIem2/ICF0j
	 yVg1PPKG6vT2exDF5kAmrG0/VYhN7Gku0+eRGLfaUJeNd+w4idR+8EXV9hoiWfruGc
	 egThsSDasfF1WM0WmcK6Bfksn7cR/g8Vnxg0T5G+F1Ir5Cuy1WL1XqWlZ4BYsAVMWK
	 XbySBkGWrgD8nj+qk/uaSIF9UhQKjWujaIs6mq6if0TFVzrKo4Rc+ZJI9U0TIPYUu1
	 hTK/XW3J0ywWiRrq31OCrG2tyu4GmIVQwNdnSMgOMJzf3PHgsl7Qwydzzjdbn6jn3k
	 aTkWJNrEmUpbg==
Received: from [127.0.1.1] (203-173-6-153.dyn.iinet.net.au [203.173.6.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D83736E54C;
	Fri, 13 Dec 2024 13:28:28 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, patrick@stwcx.xyz, amithash@meta.com, 
 Yang Chen <yangchen.openbmc@gmail.com>
Cc: Jerry.Lin@quantatw.com, yang.chen@quantatw.com
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Subject: Re: [PATCH v1 0/4] Revise Meta (Facebook) Minerva BMC
Message-Id: <173406770843.422541.3788323988670647121.b4-ty@codeconstruct.com.au>
Date: Fri, 13 Dec 2024 15:58:28 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 12 Dec 2024 21:32:22 +0800, Yang Chen wrote:
> Revise the linux device tree entry related to Meta (Facebook) Minerva
> specific devices connected to BMC (AST2600) SoC.
> 
> Base on:
> https://lore.kernel.org/all/172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au/
> 
> Yang Chen (4):
>   ARM: dts: aspeed: minerva: add i/o expanders on bus 0
>   ARM: dts: aspeed: minerva: add i/o expanders on each FCB
>   ARM: dts: aspeed: minerva: add bmc ready led setting
>   ARM: dts: aspeed: minerva: add second source RTC
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


