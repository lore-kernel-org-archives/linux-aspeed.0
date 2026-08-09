Return-Path: <linux-aspeed+bounces-4668-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D0EC5AD4E
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 15:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJ1P22MFsz2xyl;
	Mon, 10 Aug 2026 01:03:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786287830;
	cv=none; b=C8Y2i9cFEj7kVcEVnlb/y+vgUya8rzWoqukzH0BbbCnZf+F5LdlDne/2mTZ53C+eQ4OKWKvqk6ESdUYVec3jTwZOshSXVjqpKmw08GDGTTPdsNCxHbkKIdIEF5/RakFytKXmLVBWeUHtPAG/ukNjjus93DdTNgMEfoPkL+AsU+vI41+2Lm3ePz18axtpkU/nACVgs+TcL4MM0gHbCs/JzSOo/hGL8z22I7q3RYLz3UAkvz12wH8PvGu56fJmq+58Nee/eNEzU7/22Mtpag39+A+pcVN1HsvdcdH2CBATYSYhIW7tsGWoBua6UAuKpYdqtPOrJpi1hYs3r3DChKTFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786287830; c=relaxed/relaxed;
	bh=E/WGUkXoZP+UEyJ866t/Krhk68GDNZkyepthpjmm2Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CobL2GLCqhkKrWKd2sA5hb42qIT2VIxtJCMem/G12aInHecwRUvpbUfVTPOrm5JHWn85KtqUe4Fy4+qtCcMkaurDFUMz1Jq1JoZ4wA/ruwzlUDlrFwa2MgHX4UZLUj0uE0t0EwLTk9uOYcqTYhYzSzPqOSQ9CjyXkr4xF0AVMQP+ayIxPGROAVXdi8JtOcNKKCgjs9p4wn10JypTojmlTbpQDdhE/kVoXVj4Moi+hJn2IIIbeIx6A5jU8TZzleH+hsdk1mHYhpnI26eJal9gD4v9rh0GxNq8tKkUoOf9t8a+yFJLtxmkEA0FVd8jZmOFOp/IZze/TXCD/H0ZeEX9wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpoS9zlY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpoS9zlY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJ1P14vgkz2xd2
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 01:03:49 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1050861a91.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786287827; x=1786892627; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E/WGUkXoZP+UEyJ866t/Krhk68GDNZkyepthpjmm2Cs=;
        b=BpoS9zlYQToDxZh0T0KLUvQhMsHWkFjInGlHjShH+ISaTzU47EVM9kKo4TW0chWMYy
         GAI0nkq3x5+2PqgFpfRuhIIhj0bpgS++h2+GylANNFxAU2P9VLe0bvNbLCQwLpPfxa7e
         xperbHSysxVWimeseeu8182vzSIvbjNi8rrA1sZU+fZIRjbyTyq1eq3WzCgrPAdTMQPF
         Ib1T4XBLBVo/pdpyu3PUqiCnx3G3Cvil5Lthy7bbIt98vSvfED+KSfDAHdrGGev9/ZT3
         /byZW3J4sqcwwBY1W4ovW57UF7eOAOFA1TJEvJNj+8PkUCcCcawIuFfd6q2hDxzWN2YA
         i0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287827; x=1786892627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/WGUkXoZP+UEyJ866t/Krhk68GDNZkyepthpjmm2Cs=;
        b=o4Sd/WapOGHo7Re5U3fnrEKdtg9DmqJr8cKEYD383DXfwNIvXhkhKr6gOCO4+gairf
         szXVevAMS/qnn3IcCSqWhNSBzg8W35ceceiIaFpovc4h+7SiUQl3SFE6Xyds18x1iFvv
         OH2vq4NfN1uEWnFQXt2Uj1xj6Vbv2RmAdvO9j1j1lASMfOM0C9k/BpHsTsA2iLez7cFn
         HyPOwVNDxJVEBcGlyozH4pSoSAjBaU65e9ey+m9B4kh3mQv9eRUb9LuIWLBptGL6aBwP
         uZ5/S7SlI4mNfuKZvdItzGTW9OjjL57M6Q4AonS7iz3gP9iy1HytDKoxlmEUEtbvghcM
         w0Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/FimJzSl1fxFjUIJ7oUWNRqM1l2MGCh92f/n/gFFxRVLWSqSku7cnx5PwQfOJs+PCeL6tyyOdrfm1q4g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpPkgo9yOI29yk10O+JYB8H/shv6Y0Vb7a6EN+kZbSpQZfZxLl
	/nQAhOii4vLk3ijpR5nFUFsFDfpiWYbc+YfbGuN4neoY0n1ActMwtNNz
X-Gm-Gg: AR+sD12FjHYfXKOIVs6V0SKkd8Rt3t8mPPhLaWyIHrwxbSIzu/9KBCLb/H9DQbjNaKp
	J1XlrJk37/z/UZj0SpoC21Jic6r3yBhLzjL8de76Yx/vrYHff3wR+mW0sR9J6846ClTS+zCuup2
	0aT0boNLHLwknr5vGmSU4d5OrM58Y7yJVq/MSJMgqByOMa8b/0exRZq/8pBPD2zhY1v77DyH4nu
	aR5hSEBBwK8ckVwDgtcbFAaK3hli8w4d6D86DLfq9FUsHZlgreFr0MpO+2uMm8wYXB51zer3ZPx
	z3YldoT71DpxzBA+uWvK0l6iyvYBF0QY8Ko8xZyJcYg3QCyjXOtl+IKlQBwVSX0uEflZ/HJp0hH
	DcLgi+Y8rS5qqNUKgQnoUH8O6opOzgzx77nWdbhMRS4+lXE+jCo/iMeeJ/zSICTerGcOwAB61tm
	17wVZ4K257NWu57vVnhJ411ApDjrgYjcV5XhL8hdV1XhaBLa31WyRPSLk1xTvyEQMZ91e8v5WPv
	RwQrXv/ys8J
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3903c5448dcmr37987775a91.4.1786287827273;
        Sun, 09 Aug 2026 08:03:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101a5ee91sm26113119c88.11.2026.08.09.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:03:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 08:03:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] watchdog: dw_wdt: Propagate errors from optional IRQ
 lookup
Message-ID: <fe5952db-09b0-4e20-ade8-fb9d28463440@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-3-phucduc.bui@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807081652.38692-3-phucduc.bui@gmail.com>

On Fri, Aug 07, 2026 at 03:16:51PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Instead of only checking for -EPROBE_DEFER, propagate all error codes
> returned by platform_get_irq_optional() other than -ENXIO, so that
> failures are properly reported to the caller.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied.

Thanks,
Guenter

