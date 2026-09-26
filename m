Return-Path: <linux-aspeed+bounces-5052-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E01C9832A
	for <linux-aspeed@archiver.kernel.org>; Sat, 26 Sep 2026 15:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsXDW4cSFz2y2K;
	Sun, 27 Sep 2026 01:53:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790438027;
	cv=none; b=LDtbgz7tRjKSxfH8wMN+plbrFfUzVQxQdb8jo90ec/ql++7QGMis09whbRLLcwjdQTRfDvOHuF+y95B/7htkAEAYuLJp003MXHxxxSxh11YF4/qwsay6HzkeqThuxUYKOBVwje4OUtbcpCC7htTLLS2S87P6Galw0Nr4CNz/6yN6qo01zC+p9MqHZpAB0RQZ9QPIhcmPBk+WySqw3X+Jx4pcbmfifpFjGVP6NyN16vVE7bXQSf99mK8PsZku+eRHYKfktgBg57dkz/hiRAPDb2uasA9rCk3h552C+THyUZ2TLUbcNRJo2BemNnCzyl1kODuCmvLE5HcztOuyYk4LOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790438027; c=relaxed/relaxed;
	bh=d0e/d+ZsVpIEKqzITxQ/alWcQJ8JNxkp46Yk9Fwuek4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5YWI/Ev2ckmR8/n4EioXS9cmDFs8M6aPH1oqDNfty8NLmYnio7AT5LUdYGbf4bXO2/uP2IlFES+1oEv4d6saE/epN8LOTtTns3Dc3f+BjXO0kjYm8T8z5oTrKRAq6oxX2c5QCuWqhn3HtFKoOfPvxOvGmZn5THOt8hl5RUQPqW4NLYXWRX9rPB7+nr77pbydUvjFypLhoAEJiII1clIPD/+7CVHbE2sr8BIHycPnQ53v2qhRQFZEJjwRPPx5qV0MVRz3jKmUk07k3s6eoyaDBcntppywflMCKtHU+zAGGJHTKvgnklnQjUWuX8BQfe2/A8AdvJqIxiWYf1OVjSaOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net; dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=bRLsAMM4; dkim-atps=neutral; spf=pass (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org) smtp.mailfrom=lwn.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=bRLsAMM4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 454 seconds by postgrey-1.37 at boromir; Sun, 27 Sep 2026 01:53:44 AEST
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsXDS66xmz2xbQ
	for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Sep 2026 01:53:44 +1000 (AEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 632E1419FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1790437564; bh=d0e/d+ZsVpIEKqzITxQ/alWcQJ8JNxkp46Yk9Fwuek4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bRLsAMM4KoeELTAFcDHduoNvwPLDHGpIntGJy6BZ/xS4Berr+OKKcxYz3HM6YBWq+
	 KWyLOpT1oLrsFAC7BeVO3JwpES4/VfBz+BRH1sm4MAV6ILKCbPcUby9gZgHcjWAfLC
	 m+qkEzP/vLJ3FGf5t1YwRTtvuPAja2ibYinZP7SVy5T86VAKIw4W/2/UCU22Wuzoov
	 fbY0yQz1hSAqoeXQoDBJMPDqwrn30g/ney5MzKRcI14A4esSYZpTQmsuMpcrhzOKxt
	 GU2ZqLh9NTbVD5SwSuw/mhUMbUPqbKbr/SF31Jq5o3nic7Z/I9NYLs6fle6eOu4QAi
	 jHVKjhhoxgbCQ==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 632E1419FF;
	Sat, 26 Sep 2026 15:46:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, Shuah
 Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/ABI: testing: aspeed-uart-routing: use literal
 block for console commands
In-Reply-To: <20260923024918.840039-1-rdunlap@infradead.org>
References: <20260923024918.840039-1-rdunlap@infradead.org>
Date: Sat, 26 Sep 2026 09:46:03 -0600
Message-ID: <87se2w2eys.fsf@trenco.lwn.net>
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
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Use a literal block for console I/O so that the lines aren't merged
> together in the produced output.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
>
>  Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

jon

