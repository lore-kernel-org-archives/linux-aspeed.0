Return-Path: <linux-aspeed+bounces-1030-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AC5C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 01:26:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGvM332R9z2yVb;
	Tue, 18 Mar 2025 12:26:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742261199;
	cv=none; b=Kn547GqziaROrbSwL8dI/iy+4zHwAcNqp0MX4wmUgouenchnjNSr+Jw36KW15lseKwyaojg96Kr9G3Qv/TNJN3wl9h27Vsb2Dd7X4VqdrCPhPBJzdse/jN9UlppZt8Ium8uPfCPfD7iW0zXgbbTmqLk6jZ6bziZEUqoA9eOWJPGEvZM5BwBeI3eIImJViBK4n4kiUjng+lz+kvP/hMhKl09msukUOFZ7l9HqEybZ8lJ2CNvvTrKZzcvVnwjZkPQkNzNa3ETEPKUONlY6QcKio/1ZQ3HUPcq8rU0SC66qINcHX1DoDKEobCP59QzVur1ED5l78FjVTEfBpOCDTf9oXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742261199; c=relaxed/relaxed;
	bh=8qKvfbybSgzxVC9QLPwnRVKlfys38kBlYo29Mi3CfoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRLMX++KfRad3kAqaiOb7vb4UTyxk1o5jNySSBXM9V8sX2OdRStKzKLmumVjrmbcQ2aAEVPeff4h5dGb244FopXE/tnz6FPUbBxSNMw8WnZLrqdTX4nvrn2UVRUdgwFnVvUaB51xXZ6/ktrDknpU/av8QV+dodrANmXdpb2sHGRRXQzX2yfs3yHlDo84+2Phy7tH0QAh78OGApcjKadJ7yQwK02QNGG/CWUBDkruc6N+9G3/O+Fi9EgnpnkBkET4YE33mp40DQY/Z8jv0THoQSumJjIlXcMKR9eexGNuohwh/j09iZuTmIw3EzvRElzwPWHK1G37Qtc+/S1DtUOpZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=C+NGQUgu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=C+NGQUgu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGvM26n2nz2yN3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 12:26:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261198;
	bh=8qKvfbybSgzxVC9QLPwnRVKlfys38kBlYo29Mi3CfoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C+NGQUgudkaryNlxpr+Bh9rYvk2OfGEBFs9x7fJ2Q1bAnXm9xqsV60gCn1kJVjx8r
	 7UWvgJxoo9f+Xas+7ze2zyTisPdjRvt6v+tyvEBxQo8432S2UhwskhE77CAfXjzhYh
	 NJAeFE4CsA3JGGjnriSHv6fW0fAZerqwjUzFfigHB81o+fq3Tbha3IWgEaAfV54MwR
	 YzgoSJnCuq2BMgIvrT/xetkcK1/rFhAKLXCrX3q68/9a8WN05p/HmxO4NOMnEIz7gi
	 90sFG6miV+Bm5HK1y1SxvCXjLaPy2ywC7atf/aY1fOTy+H5p1TE8aykGCQS7bnFdgX
	 Rm+VpKU4VqdUw==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C0D7F7A5D4;
	Tue, 18 Mar 2025 09:26:37 +0800 (AWST)
Message-ID: <ace3d4bfa8bf4d59e1578a5f8b7c9aa92a25d85b.camel@codeconstruct.com.au>
Subject: Re: [PATCH 14/15] gpio: aspeed-sgpio: use lock guards
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, Michael Hennerich
 <michael.hennerich@analog.com>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Mun Yew Tham <mun.yew.tham@intel.com>,
 Joel Stanley <joel@jms.id.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 18 Mar 2025 11:56:37 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-14-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-14-1d5cceeebf8b@linaro.org>
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

On Mon, 2025-03-03 at 14:18 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Reduce the code complexity by using automatic lock guards with the raw
> spinlock.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

