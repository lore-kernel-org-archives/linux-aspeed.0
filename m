Return-Path: <linux-aspeed+bounces-1493-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74041C71155
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Jun 2025 03:06:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMTCf1NfKz30RJ;
	Wed, 18 Jun 2025 13:06:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750215982;
	cv=none; b=cS+/b353WQo0rBF+T42tFHEOtJSRfrxC4NyhEdnnq0rnp3bXzyYeGtL1GefCMSROjKZntXWkX/IAI6y94YfaTo4V7QUYyum/grPl2oM5ci6cxqsb+YdYMMox1T6XaR8Bd6DvQXDs47KgELV+w4J0zAKhVi8+8ealNVL9u3+KP3RLZlHu21tivRV1sYJGLDHA5KukS6t5icf5MjqCBWH8fkqMPC8ccjabDM6cfcm17jcGc07sx3UUFuLJ4l2jNeM2bkxicThq3dhWkVidEuaRTykLHgH3bIwGMLyj1P9YoitRpxS+wKkCR+a7OP+oKsc1OuvyVj6BDehyHpkDAjHN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750215982; c=relaxed/relaxed;
	bh=qN9NPv1XQrsC3dwPyHVqoYgRHQm03qU19l77O6/+NkY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V65vAy8EWBZbLMl5pbxnX/5/xAAgQmq05/apVVnl+Edk/bE5q4P6jDwzYyqusS7bk9K6cweaEPKe7GYGl94sQNj/JLb8pcNQmIomP5hTCojpJ03/lVpU7c/HhI3GTUCYXpHcZnFADIogHr6nA3r0A/l0Ag/yMIKyYTIZ4xQU+ZfA1m2xfjVebSSCBhwJAQ2iCxXY6UoORQrUJRRmcZkCQ799F0W97081jrUHFNIjbVxwc/FJgHpUpar1VNMehy0ClpJPiMrc4uOjoZCTt5QHuXXDfoP5YvZOd7vN/nb1S2/5++zOVchAIq8F9wyLrt1lnZQjMTkkpfHwrjS5m6xmWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LTxBQNyB; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LTxBQNyB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMTCd3VR2z309v;
	Wed, 18 Jun 2025 13:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750215980;
	bh=qN9NPv1XQrsC3dwPyHVqoYgRHQm03qU19l77O6/+NkY=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LTxBQNyBuJBxJiNhQgy5vLgg2Q1cilu5sqxx4AN8cNHwXn3HgrmJ49pIjCSxchnhf
	 k+FNxzchFLCwwXtnx1qCPCG1f7j2s3vs3CZN21KTO+p/EaEXiSUeIjL8bM/PbWThMX
	 fq2fBARicrss4AGOgQ/ZU368YBmgxKZkpjza4B2yywBn+g4IwGNksuuUUfVXxbqQ7e
	 5LpdYkclvvubJ3u0UFwr+Rv+4D2o+67rXcweW/LXnMiQ/f4eF4kRCHw8xTgZ7ZcJqJ
	 M8vbxOhLi9T5AgbG4Jr+Gp33Ow0BZ+P+BitiamvWb4iimO95tuBYdl4DJYo5oBqU01
	 loocYLcuF8ttQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E875E640A0;
	Wed, 18 Jun 2025 11:06:19 +0800 (AWST)
Message-ID: <064a5583e43ee0b67da1112fb5fc9fa421e4f96e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 8/8] mmc: sdhci-of-aspeed: Add sdr50 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:36:19 +0930
In-Reply-To: <20250615035803.3752235-9-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-9-cool_lee@aspeedtech.com>
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
Precedence: list
MIME-Version: 1.0

On Sun, 2025-06-15 at 11:58 +0800, Cool Lee wrote:
> Add support for SDR50 mode in the Aspeed SDHCI driver by setting
> capability shadow register.
>=20
> Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

