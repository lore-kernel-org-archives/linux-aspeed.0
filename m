Return-Path: <linux-aspeed+bounces-4681-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD7C5AC67
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Aug 2026 00:26:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKTnL6mpHz304r;
	Wed, 12 Aug 2026 10:26:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786465329;
	cv=none; b=kSUCqY6obKDwWfWgOtPx9DbQIxglxA7zUUOBe8uuRlpVTg9BjIM68k1Pl4RnRK6E8+5UmuPNOnFII2llMB7nzK2SXywc/gdxkjoeFlW8BZ7SvV/Y4QZ76Bdspq9UqP1rQhgx1+xLl0FTx2i5g7kWGtyLBSN8+PMtDXMIeKsXKqfaXvKN4P1Le1swV3RAypEpXc9/yhIJyzBj4ZPpIWTN74s0/mNxo3+nFmulH+VnG/j63vf+VPQlqsMAZ3CwKzxbmKgM1nE5wyIbFoNX2kFMSvYMAk/qHbv4V2LKMPeZlTeEAtoAsrwVFb6CmqaoQO0zn48Q6Yr09nsd0as7xYIhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786465329; c=relaxed/relaxed;
	bh=w5NxFq7IcCs1xSnAO+oR3n9k6fwPCVP/WmcDz5wXiMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbZ8PlwmQIVdV0BvIKeoqFBGxQzvkjXiCEXmka+FbwvTV8T9XZfo23jKQpqfQXxBPA+ZpWNpIjcPEzlAOp18sW6UJlgict78CObslixwnIIiQlMY56enaLV46k0F0pAu1jO9JPbJWbcMmjnUKvzcDXxq7s+/PvBKDjLfB71DwSGCMl/HHozaubT6SEVOZQOx5fl3NLP+ltquqwUpan3pojueyp+qQWd/goyF7kzhRbQFdSt5cngYBoUOHWvzVUs+UXB64FGkcgBY9f0MTVQZ3YoSTQWm/00xplwgu1uBIXkctHj2HgARI0nxXKDxSGdBpij0CmdSgWBb6rCWmUMjvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlcMyWvB; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlcMyWvB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKH2R3Lp7z2yrL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Aug 2026 02:22:06 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4954dff6536so25758385e9.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Aug 2026 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465322; x=1787070122; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5NxFq7IcCs1xSnAO+oR3n9k6fwPCVP/WmcDz5wXiMU=;
        b=HlcMyWvB1JqOMAcvTstTp/PpuG5YZ4+CiNYWRQF3QI0iGWBv/pZU5Xbuv443dK3nyd
         qfgRL9ZNvfb9qf75FXAR+rhKAgYu0drcjzUd03G9ocnKAB/ZTpu1hNAXAJ3vO2bzjrnt
         L4vD8IR4xpFkRC1rDHdBnFEazQGa2DnkUtSyYPrUw8slSCRvYFZ5qXbPQTn45w8Q2qvm
         sPmhdbw5TdQ/XeMU9Cm7z91QWlgPbbS1wN1Kjs9LR5Pwt8e7E9y+u3l8E0/CfWIYZYJo
         SZLQgiEh2ZCLXR+qYxVfsTeQz/jxYk8o6h+g6TEI9eA2emu4PNRydhNrCnKwbYZDE26+
         pBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465322; x=1787070122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w5NxFq7IcCs1xSnAO+oR3n9k6fwPCVP/WmcDz5wXiMU=;
        b=Ikjl9TjtolQnAZb6CvQ9ilVwotoLL2nj4fsSGfq4w92Fm+Hn2cjs1i9MPgfN4VWBmx
         8+nQSPW7UuX3h1pE+fwpg5Y0JhKLLZG+owaoDDmwcGj3e+T4j6KQZeDgodJDPL+vL43l
         I9OrZRQni3YaH2fy9UuIGUlgSZhRJ9PAdzoPo754cbz7wFGnFUNKXS7m3RjYydJLyX5f
         sCtlcV8lZzc+de6yEE6KEZaWide3l2kR5omBUtuHrfEcpW8robu797XvG/l8xmzt1oZu
         U/nda7LtsSpW+oCq0Yex604hjBeDeAQbc+YRhqmuQnZHqFGoslOEWVyy1O8iiZCJ6Y3J
         XINw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/4Qlxt0iFToKML2RFYRbvBRYQuuekz1KebUSemkHgwOigZjyFZXE3u9puZmV3ZnU0KTFWPPKNnTHxJQ8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzulbpK5WrD7qmzqcLLZeDqCsw7A+xoPcL20iXIwwZ3logCJuEr
	ykG+mi20/tYMcXX4cz6IDRFphjpXCRo9ex5sm4wCOCW1/exeH0rDglaK
X-Gm-Gg: AR+sD115WxD3Bs1tJVrDe5BkRwuOwhh7Pw9flXqrGJm+jAKXZOEJsLs+hsTnnRp9RRq
	X+fWgGkuP2pCP/+HwVj6JeKltZL0tPX1gyQPhCERbpMNGFEzRtb6OCi1hMkTHZr5FiKbc7TrDdh
	q5B3qmGscMsBRFjZT/KkyXytcPyANENpsJNThvZcXHQU/sAFf14NTie0rBDgLjGiSfdamZU24n8
	DMm1l01/2cQTMQSsNJNrBDjZ1OyJN03QOkT6qzDjmBQzQZ4KRae4umE+OIClR/nCWxAxqNMhs9a
	JZ97+B3zxYkB1paSAcFtTeP8+ZIsw0+VVsZj+wOurAQXKQQJMrJSmdEa6haDoU7xH5V+HRKEj+m
	R5JNM4RsU0Oy+Fm8TJIrz1TDyWLNk75XXEeIKWcZ8/r7Ax6PgV4czmDJPEebm/KZGIhjX+oMPqQ
	8JeUqqCiUAu2xGlEnZztb+G/xWxVl6vdvAxszxt39hYkZ8e0CGsyprgZIi9oAcl3dGkE5vNudSk
	Y+ChOE/OpD/CN2iriP+nX1jHCPO0Mt0htP4bVTGvINXR66BZjfkI/G1pUapaAsZnafyQC3iMjLH
	go/t2ARRoqU5QWZJsVRNIzFn7+dmdNvcKCWG0p5aLbaSwKewScfU98TquIi3urPtJ2jf/yk5b2X
	XLj8=
X-Received: by 2002:a05:600c:6088:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49978475c11mr79962715e9.19.1786465321722;
        Tue, 11 Aug 2026 09:22:01 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977de1fcesm31270905e9.1.2026.08.11.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:22:01 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:21:58 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, Brian Masney <bmasney@redhat.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: aspeed: ast2700: select AUXILIARY_BUS
Message-ID: <antLQUuTFC_NXWu3@gmail.com>
References: <20260712160301.98941-1-kmehltretter@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260712160301.98941-1-kmehltretter@gmail.com>

On Sun, Jul 12, 2026 at 06:03:01PM +0100, Karl Mehltretter wrote:
>   clk-ast2700.c:(.text+0x147c): undefined reference to `__devm_auxiliary_device_create'
> 
> Select AUXILIARY_BUS directly, as other clock drivers that create
> auxiliary devices do, so it builds regardless of the reset driver.
> 
> Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

Friendly ping on this patch. It has Reviewed-by tags
from Brian Masney and Andrew Jeffery.

I don’t see it in the clk tree or linux-next.

Is anything else needed before it can be picked up?

Thanks,
Karl

