Return-Path: <linux-aspeed+bounces-1810-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D907C83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:44:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnW216Zsnz30T8;
	Thu, 24 Jul 2025 09:44:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753314265;
	cv=none; b=e3c7AyjGgrShbcd6Gsx0Uo6LmPiV1fvq6/EnAyjtAPhPITIlQsSd3Nd6ja4WWYPC0vsHfofGXyjKxIh5/2pYtRoDpYz77Or8gtJu5Ps8KwbJuMzmrrM4n9HUZJUAUAWtl7PCm8AyCIhCEaT992Dh9+3j+zLNtsCMpPZgcg77fihOH6TRvbNEfvwFuTDOANojwk8WoFJvgaG9JcdqFB+hky97As930q3KOizmd2M8uB3PwBCd8kUhFVyHBC10btlQVgWDf31/904LIQLjusM846VhjcSggkEhplpELYWRzGX71OA16tiHJkUVEyRBERAUntTSh49ps+gZMqs1Vshp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753314265; c=relaxed/relaxed;
	bh=egOR95e8pzUIXHVjCnVm2bcSsTXIg61tjStS28c2/fc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCXgNlO5mfwNZQh6wASqwRcOB12O5fwHbc2WNGw8CSPS0NNVGI2g0hvpUty3Tlyp3JPQJVtH44tVIUV1R27z+3G/j98DFnf/rcHPybeAdYETzhVsD8yZT4Uop01yDoyEf09rhO6WJeoQJRvDYGJgjZJwKVELBuuI7GTaTh85DSnG46vIG4G/UiMpM2W6Fu49KEavpgXJmXq9vlrStCfxqfM/Div0NaMWZPTqR2GIwwNhoabHwMIt/fbs8GFuC4Zaz2zNzfVzcXriyRV+MdOEvrF3r5Opw0D6RMBgOqvHyiCI21gmopHXf9ftiaztHPjJQCyZgUPEBn/B/qHX+v1FNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LenI6IoZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LenI6IoZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnW206L5Cz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:44:23 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b1fd59851baso362497a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753314262; x=1753919062; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egOR95e8pzUIXHVjCnVm2bcSsTXIg61tjStS28c2/fc=;
        b=LenI6IoZTSHs4+gxFJNS3LGw68nf/NekiAUqkRJSMaIa0KAiv5frMnNkBcEGzvrFMO
         9fZpsWSo1GYCV8/exLc5NPHfy0hsqerGYYA2tEydsjKJ8n5yq8WhI1bS01Wr+Uq4XtU4
         BfTEKM5pI/fwHQhSvBpGIfTlFXtzCm4n3PC1TKT09ndt5Jllyqz3XktkDZQz3EJFGtPJ
         Fk35X6hhqZlF2K7gc6UF78FmmyH4yGfrbMjhyHSKX9FKDOMEAZ8JY9EzDu81Xv/ScarG
         Vev6LaEjTvHuOJH7e7Q/5JwmwBvzzFWiWWgWUhHrBcqiNWWR93JyVUYiby6JlNGrbEvP
         hYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753314262; x=1753919062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egOR95e8pzUIXHVjCnVm2bcSsTXIg61tjStS28c2/fc=;
        b=ANNz5gvnZcfujcEn2xzdpyL/+fZZUH3RhSEy59SqU20nzlPAN/N8BUPebcCKl/ItVE
         ZTn+jMWu2a2Yi4iEriKjhgDr8QGfyPg7SDKDMOc9wNI0YO9AAeIdv47bvsLRHoTPW1Tl
         fAbrYbpRs73IVt1L3SKC4ZoaO2kTAk3T9SraaiW2H6dAtc3xiQViin70org3VZbRVHVy
         ezkVZuhUSk6XbVbXeBOTp0Z3Idcg+Y49ZK3OFGXIUfZU/g7+/kcbgI99vIW2Nv646mPs
         anBlqjDXWTdRIBy1hhVDrP6iGEkf0fVngTww59riS+B4iswFE2I1SyiN8bJtDmPm+D8K
         S2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWsxqqH2EgSzXY8EVCenE3aCVxQs/IbvCihse25nyb+1PCvhYHU3ZGRCpohYk2w5i57setBawuCQ8X4w5g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCZ5h7MyD5jWx/f4RCxrxal9qdRsIgLnauxRKR95v7edbygzWo
	aQbPVpM++s3kaubysnoxDXgdymbiv3yGtzPWfJPKKuGbBNC51Xoprmm8
X-Gm-Gg: ASbGnctThSuzcVWWA7pcPLFBJIjIe3gz1vce0Mf56JUa8g+Pt5TKdxSISNri7RyXa28
	5PKcAxQP1mZ4nh+pK4i0Hvs5nUK1ZVtFPfK8qKuY7hX8P5LzRviVAEvpn5NHrg2XmB+LBbbDbe/
	Faq0DHw6L69G3Rmp1m5knW040gV0WqJS8XL9Cyh6rt+EaGpNEo9vKynnhPAWfhOJOY4XOpdPDZv
	ZXRyeMzNuESe3M0wlEjzHfEygZM/pRVdEKweJTO+Kj9qNRzoz8RlM7IWIEVDv/Nzo7FCssoqlSn
	hJC4yonEz5JVTpyAhGwGNRCkjYD0ajsEDqywnf7Zmf2ENKlV2ZoXoHsTreagXNqcU8CpO/2jw2U
	Zp4f5VMejJrw5ysA2szXqdGyz0/wxY4ryDhuHsnK8j+WUPnuuGjuHohyMnp7l3dgrj2pCcd+5qM
	E=
X-Google-Smtp-Source: AGHT+IFDzS99qUj6bsQTcDicde763FDogEGZYIzf0CqpnnHK6ECZzmfcAqK3CJqUDBhhH8jFJnC1JA==
X-Received: by 2002:a17:902:ef08:b0:23c:7b9e:163e with SMTP id d9443c01a7336-23f98164116mr54444835ad.11.1753314261687;
        Wed, 23 Jul 2025 16:44:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490222dsm1371765ad.182.2025.07.23.16.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:44:21 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:44:18 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Message-ID: <aIFz0nq7qHvzglwZ@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>

On Wed, Jul 23, 2025 at 04:29:56PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
> each BMC platform because eMMC was removed from future Meta Network BMC
> platforms.
> 
> Patch #5 introduces new BMC flash layout with 64MB data partition.
> 
> Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
> and "wedge400-data64-bmc" are identical except BMC flash layout.
> 
> Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
> "fuji-data64-bmc" are identical except BMC flash layout.
> 
> Patches #12 and #13 add Meta Darwin BMC and updates devicetree
> bindings.

Hi Andrew,

Sorry the patch series grow bigger and bigger, and thanks again for the
review.

Besides, the patch series is applied on top of the latest mainline, and
we may need to rebase when v6.17-rc1 is ready. Please let me know if I
need to hold my patches till v6.17-rc1.


Cheers,

- Tao

