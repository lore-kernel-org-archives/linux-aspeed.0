Return-Path: <linux-aspeed+bounces-4532-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5040C44536
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 12:48:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4vFN4pFKz2y8p;
	Wed, 22 Jul 2026 22:48:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784724520;
	cv=none; b=amUrbAh4ECJAKdDS4Fuat4VUP7FYEOXmfcgKkjyEPKXc/TgRPBd4sdDtkpMn4neVZ3bEPxw1LjLeuSyvaJgXEj3DWO5F9HgELF82axsWEQbZKLNrMXuV2MLWLCRFEuSDQkxBRyINTflyxI0HNAt41qrPAZGn6j/SA8/3VlBu0bfETMiTznWh8tt7Sco0NIOh9g9iPo2rkqOR4GpZCfoHROkHutAKUNQMZ6BAQOQzraw1CeBIUqQwswTuAWz8u+55HFmOti5+AisK/TMSMeKkQJ6V+Vq3gx50Jd0CoIa3LOF1FhvxS/nnc4WCIp3NyG0cp4DbuNAYEXTzLWeKxhyTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784724520; c=relaxed/relaxed;
	bh=vIKqOF0CXddp2THXSgq1DAjEmO1R0dy2OSrDEgdTcbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H6JuuWoFxq/nK0ie863IqVtEc6z/+DJUziVSXyCpIPrLPQzNqBQNnA6LQw3xJbOPBlL9rNmeoyafDOp3/awSQjfI8De38KoIgaGm1ufJ4S49vu8SvGIa1Zsr5ONpR32Tjlj0ajZl8g1qvKqUKzwLsM881U3rkF6oQAzjr5HAhwH3oKhXR62H00gD1etHC4vRXP3B4/a/eIsD6oKI95eSAeDPR44zQVZ0XgsHLQRZ7YZkGZiHUJjuxOcL1zC3vIrmiHzh8hheFjMcKc4zAKbWSbMBKohfZqolf3OYSnmfjkJYo7Yte8mfZQt1Y4ebGpOP50jlwEAQHUP+CsexrIkgXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=R9upcpzK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=R9upcpzK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4vFM2Vpfz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 22:48:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784724517;
	bh=vIKqOF0CXddp2THXSgq1DAjEmO1R0dy2OSrDEgdTcbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=R9upcpzKFwjE3zypvDbDNyhzISJKXUqpL5pqjiZIt7xyNwYP6KqwEGDnJhZqMYW8L
	 BTYDMLVHSxPVJNyN64VY4wgQMzjFYtBT3Zn48cAvjDjszCI1mZD6FYkndKLxNrHS5N
	 HpfJkpQRxFKox61fswDA0BAry2c3fuytzrfn4lPtnGNowZdtiVC/k6DpBF8VjdNZyj
	 1UyMEw3sq6nKoRQyIqXrfIvLqphPmNcaSmHBhfMZBj9juums+YKqhhMJxHp6ODLEij
	 htlprRN+JSIqPz6q8IuUe/sKpE+MbqC1j7LjZ/EnbqwgYVVMyjtfI721uNC3GnrxDI
	 5ZD9Rh3Edw+Jg==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 58590662E1;
	Wed, 22 Jul 2026 20:48:36 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260612190744.172638-1-karthiproffesional@gmail.com>
References: <20260612190744.172638-1-karthiproffesional@gmail.com>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
Message-Id: <178472451625.1415280.9493751198445442679.b4-ty@b4>
Date: Wed, 22 Jul 2026 22:18:36 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 12 Jun 2026 19:07:43 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() acts as both producer and consumer on the kfifo:
> it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> the IRQ handler without synchronizing with snoop_file_read(), which also
> consumes via kfifo_to_user(). On SMP systems this concurrent access can
> leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clamp
> to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> copy_to_user() past the kmalloc-2k backing store:
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


