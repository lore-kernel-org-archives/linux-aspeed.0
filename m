Return-Path: <linux-aspeed+bounces-3498-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE71BEF070B
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 05:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8XwZ2QVrz2yFm;
	Mon, 09 Feb 2026 16:16:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770614174;
	cv=none; b=PL55Om5oGW5WJChWIaNuOpZ7gHR+7ZDy64pUAneAXpY25sxDJBstBkqXN4GYpOenbqo03P9j1mHubQ6QWJu+Pn1WIA3OgVQupaUzAQCKDh1xxHQXsikAG3BGDkW+qwE0sHSH7cEfyNSTc3v7zzKkzkxVoTgQ7yHSVye+unOdWSeTmi6cahM4SYZFM2wyhRMNHuICNNgBHWqvDipqNURxcyV8Y4BEKFKXV4CiEeHqEKInMb5hdYjOq54TUgHProUQ5r+BZK15xac1Y8HU/KI0DwMMk29PNoEpbD1fEoxKimoeMTBf/uKhOGDqeNWzTU0HHDCUgJdzKmb2YcFpG03HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770614174; c=relaxed/relaxed;
	bh=4SnKV8rhcT2ZNmnJKCkjYW6cLKKaFbPhTH5lMKC71Qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dp1MArMVEkeb7ojTWuiZU+fsgWI+znTAewVjxMjFastLWi6wLpRgbI+up5QIjaX3V3Gf4uRk57Jk8Um2pHx1SYmEIIpVqN7sqItsVbDNRuVpJwv6zjMuO2sYSkvaRPG8N272g782CxLAJ3LWRaXpRskoYpsQh/vFWg0Os88drQZkx4UfGxOyIEFafDphQxJkspyUrJyuDjKCWwEOPxs1QEcx26WgRCkNFteFzzATY1/czSCMFwhKfF8YQNQtGCyb4/KW72gvIkL0wSbtqlfLAW4W6PZawyFvcRzl/5rdBbEMpn8mI7W8bAImlsyROrcQj1YyepodDjNJkwUgyuTiZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bpEHbih1; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bpEHbih1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8XwX71Tgz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 16:16:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770614172;
	bh=4SnKV8rhcT2ZNmnJKCkjYW6cLKKaFbPhTH5lMKC71Qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bpEHbih1GKL8CIJ9fFpS11yPIkuEIjzwOyOaEu79fUx1bOiEmVcT0TNuTRHg0DMtG
	 7v5m6mxyUC8T6fOHUkawaISBXOvtEn9eLuby54o7FCjlAr1f/R2civgd0vdggITMnC
	 2YGbs+BsHW6+MLDJIM64I6Vy2u3cfNYDrVVDrWxoWi+uvWRZSglz2D9UTuVXxTWYVZ
	 VLiC06XxYl5m2015lhJ5r4hyA/YMaB5YYNNNyuOE66C4IYF9DAmEbQGrlhvpB+2Wg+
	 0GLayJy5ZjSvtjuv3iX3x4+rHT5b2ho8IpfgtorOuST+1Bk+pXGbodhWS22gHX277S
	 ZNz1GsjrBnAxw==
Received: from [127.0.1.1] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BCF016024E;
	Mon,  9 Feb 2026 13:16:11 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, Potin Lai <potin.lai.pt@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20260122-soc_aspeed_name_fix-v1-1-33a847f2581c@gmail.com>
References: <20260122-soc_aspeed_name_fix-v1-1-33a847f2581c@gmail.com>
Subject: Re: [PATCH] soc: aspeed: soninfo: mask table entries for accurate
 SoC ID matching
Message-Id: <177061417170.926448.9969681893139297177.b4-ty@codeconstruct.com.au>
Date: Mon, 09 Feb 2026 15:46:11 +1030
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
X-Mailer: b4 0.14.3

On Thu, 22 Jan 2026 16:37:56 +0800, Potin Lai wrote:
> The siliconid_to_name function currently masks the input silicon ID with
> 0xff00ffff, but compares it against unmasked table entries. This causes
> matching to fail if the table entries contain non-zero values in the
> bits covered by the mask (bits 16-23).
> 
> Update the logic to apply the 0xff00ffff mask to the table entries
> during comparison. This ensures that only the relevant model and
> revision bits are considered, providing a consistent match across
> different manufacturing batches.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


