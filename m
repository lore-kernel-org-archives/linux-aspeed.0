Return-Path: <linux-aspeed+bounces-2898-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C820CDB47B
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 03:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d72Cv6Nwlz2ySq;
	Fri, 14 Nov 2025 14:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763089739;
	cv=none; b=QtmpBk6IiqvF/caSUG7A16J0uHAOcZt3UGfazDS2IE9oDH9TvyJ7+pJMkgm6ifoaVNvcSA+OdMy16YfNT78p0lan8JhK/wP9ToJaZHtJsMa0VAqyq+FL2flShjsGsb1+GTGwPrDcVKgUuoaXrnV2Kg2axXe1GhzEw0TA081fWeVRQ17e2aL5ebq4KH5rLw33RXInyyDybHqfqa8EGa5oXWxs579l8/xA3Y976Lcino9muMy+QPYZgYNn1pb/brHGVC4+QjcthHbGJgLF+25HiXMpgBWkXVRHA+3E2ozGeM7lrNQoeN4OOf8q+OFK5ofD9fuZaTR48LNrDDXuq82N1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763089739; c=relaxed/relaxed;
	bh=LkBcRmHvmZztAg15UTFgf2ghFALYicoycTuXTQeNpLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ohC7Neos4mMasTkpCybkc3LLEUVWad+uEhdWZUpIamTPfH0P7FEvWUur09hxQbc3o4/zQG9kQ/Oek1Wc6XCDBN1qbJPZX26BERK8PtlRsqK08mpe7YQ8d6rKnKaP31AWlfJRau6Ibpg69q2A++K8oD4WNSs9wtiopJu5U5QLnHqQTlZ2VpvC7HhOq0NixC4SrqQUxeEFgtXkPGMcyrOrVT3l3+YozbGqUL8vRowgaPi0UnvM/OlQbYj0cK+/lWTbP8J7Ur75AUEFsXLEIah/3v/6hs+z/av2lZ5CYMzMxOnbLwzaux1SP9/jwvoOG1Jn6k4K78cMxeu0ijkJdS/cVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bxCFrfRG; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bxCFrfRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d72Cv2yZYz2xlK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 14:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763089738;
	bh=LkBcRmHvmZztAg15UTFgf2ghFALYicoycTuXTQeNpLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bxCFrfRGtOhiqaH6YjjW34vey7hfyohGVUDXs4rXRDpIaalml+Kg1H6rhgvU+j8LK
	 AUTtHG/70S0byNZ6N8/heuWQcliGX0ED1yD3+ASVQSWv3hpscxLjFRcLziSX0PAd1a
	 R7ZkEfQCa0XFpuDu/jxjprfJxSnYzpwPUK0xQcKxXP/u270pO4PI03vf/R9HJ+8lxF
	 2q8KHnVMvTBD0WKZ1H5YB2C9bcCTSSY89iUlIcXBy7v5eknwtoroVUxhyrWXLaQDgN
	 zGpY50iQz51euGEntKrXPAQTFDJtyZHiQoYOYReJ3u1pkY/wGG0WkYMoMdUI8s+ire
	 WRvch65URQtZA==
Received: from [127.0.1.1] (unknown [180.150.112.244])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 080CD641F5;
	Fri, 14 Nov 2025 11:08:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: joel@jms.id.au, Daniel Hsu <d486250@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>
In-Reply-To: <20251017134402.2073042-1-Daniel-Hsu@quantatw.com>
References: <20251017134402.2073042-1-Daniel-Hsu@quantatw.com>
Subject: Re: [PATCH] ARM: dts: aspeed: harma: add fanboard presence sgpio
Message-Id: <176308973697.854884.17577431047566755576.b4-ty@codeconstruct.com.au>
Date: Fri, 14 Nov 2025 13:38:56 +1030
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

On Fri, 17 Oct 2025 21:44:02 +0800, Daniel Hsu wrote:
> Add the SGPIO definition for detecting fanboard presence on the Harma
> platform. This allows the BMC to determine whether the fanboard is
> attached.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


