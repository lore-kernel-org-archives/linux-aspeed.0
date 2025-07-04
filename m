Return-Path: <linux-aspeed+bounces-1632-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194FBC83030
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 04:46:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYLgv0rRMz2xS2;
	Fri,  4 Jul 2025 14:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751604395;
	cv=none; b=dtiGdKYzG3Do3n1W/DuB/EH24gK975Y51Z9QZbg+RukneWuaKEhz32TJSu/OtswkUDcUBtPoA90WtIU0+x1ldYTy6JaBHbo+YmRDenKmDOb58pYgrkOTqLYkZ5L/vCVfkuR/PBKlamEgn+JBENxOLBrAS5po5GvUUwxtr0+Lwyh/1RtT2sVS1LGgZ87quRDwqdtp+KQ2BplPdQK1NyfzhgO+mJckqkAfz3PjoYaKihHg2WmmFMTkuJy06pWNi3XlzXZymEM5qVqcLLL10SPt/rIEMq8E2mlV9sSVInSosXj8yUeEASt2LGJpkBv52Lr7LATrL9NMgMKMO2o7+JdjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751604395; c=relaxed/relaxed;
	bh=xILUeuNzrr/Yo7TFwfYEmVtweggfhUGpHihnp3c3FuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyoF078xmOUxvCdRXZ8PxAqhLFSLYTIV21mHoE9ne8Ze/mrhtT21CFY7oK3KQR2Ow4A4EjMDWaCJeGAkjF2vXGn5ozCpu5gt5sva99du7VO4VohDKBx0Iy40g0ApQgDwW1VlvXjvQCFFN2htxSb3HDwDp0VsK9Mw3qnJ8qbAUaDdgszkCHoSGIh9eBk8kpsQf/8UHKU+X0Qw3NRGRCfSNaCn5iK7qQdfXdIOKbUBEwcpSSLePx1kmiTgHlZSUSMmeej93x7M3W4Ku/XS5waxnHSE9kF++5+N4He4JUoTBYMKTwuuPVfFUsiB8trlG+/94eOD7K1eh6nZG4niSLixBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BOI/4nVK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BOI/4nVK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYLgt3ZXWz2xJ1
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 14:46:34 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2352400344aso6080525ad.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Jul 2025 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751604392; x=1752209192; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xILUeuNzrr/Yo7TFwfYEmVtweggfhUGpHihnp3c3FuI=;
        b=BOI/4nVK8BzuETxkvK4IMPdWl6j1bvA1hwEyxsU744tz9x3vtD/0SEodwomCk3ucbA
         Ac4cmyDSunsKpEZQvj4Wr8Hf7CpRXT34lT3y7oqk9p39P0kr4IhlXt0CszGq9ROgOyRe
         d0StdB5KVrq+AVy29SyNG0VM88ZafRY1Njxh2QK9ncGDUkgRr+ddOzkiCStVhkiKTZpW
         M7hwF3lKo/hV0lvd/F0dPXJXMQHZyiYz668rRaGDPaHiQgbWSE/5g7UgToSGl2oQ9Qw1
         NO5BMv7oYHH2D60/ltTO8v8I8NpQxr9WvyvjX8SvCRFONX28pkz2FiQdVL+XcRRI6+pX
         gEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751604392; x=1752209192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xILUeuNzrr/Yo7TFwfYEmVtweggfhUGpHihnp3c3FuI=;
        b=Tdrzi9BgkQd/qdSO4PMb8hRmKSSFhiWIs2whIRz7kJm87TFDJ0Ucgiwr/fUXBd3TV9
         2DOQMVT6oWOBNkR8VDhGr/Igzpny4daVaHflhXRzZUF9n+jR+2hU2QUs23oPoUSfSrmQ
         FhQ/SBzfsTAxgpNVCGYUgqFgXNaHYLHT0k4tIwrBmFujFUXfb32mrlo5oQYe2KMKCp+Y
         IwDH/v9Z3vq8vQAc8PvtFJWOtEDi47iWpJ00xSOB1Tqkr2Uc8JiNxASwP0hQHmmFg8v9
         gc5Phj8KVK9d9cJUpQNpfJjg+YxvmBqUs9GHfzc830nBejam5nwlYsvYGt8rdJ74XSN3
         lweQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfSEd07+PO95IaBTUJAVmzVAUd92pn/5mjpV9lIloLeYUnzArD/rEjSZnF0xaN8tUVLAKuZVfDm2qxjoQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn7q2bkVivPIfFLUDEseyD5E7eknBVXsRfgAjtbmMDSUFpAL3l
	I3DJCjpfixQJT069voJxtI0L3OLftNvt7TWt/2+5a0VtAY12qm6n1BsuEbjB6kea
X-Gm-Gg: ASbGncuZHQcpxXyBrzsH+TsjatiTGlpcRMSNGYN9IHXiQjEPApZXyBt6rs3A2qrv7OF
	j1ci3Od/b1O2YhyseSWOiYOVbiu5mCZ6/BVXx9TlkjjaRxHvI/xnYvxDmNa4JiIrhVmzk9sApZk
	IFaXZrL/Addc6pR8sNueBCb+/HF63JBp7DGQ27SGZOQyYDD0RMt0PqiOyoI+1O2pvt6ayvwA+sQ
	Lcy75FfJoRxdt7blfpGXn0UXfx/UzQ8x9HBSmkhIJoFnPod2kxPgwsAAJxvSjm3NwfcTdfGI6XI
	wGentPu+wUDlQJsnsIQgFgaiaQ2TAFz22/GF2aT1GjuOSHRfzHLJtgolnqFriwCFF5UsGodtSWt
	ZrLwosK4kUi+3POWlyVuM2qjXia6S8lVgw8FWh9g=
X-Google-Smtp-Source: AGHT+IEgR/rCAd1Y5FPgmuwSiO8qntbXNx6FG654nLbacD0JKhCOt3sZTQYV6V2u/abFqRuVhjf1Tw==
X-Received: by 2002:a17:902:c412:b0:234:1163:ff99 with SMTP id d9443c01a7336-23c862a8090mr23121635ad.43.1751604392392;
        Thu, 03 Jul 2025 21:46:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455cc1asm9413045ad.123.2025.07.03.21.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:46:31 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:46:29 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 2/5] ARM: dts: aspeed: Remove eMMC from
 ast2600-facebook-netbmc-common.dtsi
Message-ID: <aGdcpfYM94Itr6ME@localhost.localdomain>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-3-rentao.bupt@gmail.com>
 <94e0c5bfe1239e7590cef427cbba405077d56d01.camel@codeconstruct.com.au>
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
In-Reply-To: <94e0c5bfe1239e7590cef427cbba405077d56d01.camel@codeconstruct.com.au>

On Fri, Jul 04, 2025 at 09:38:39AM +0930, Andrew Jeffery wrote:
> On Tue, 2025-07-01 at 22:04 -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Remove eMMC device entries from ast2600-facebook-netbmc-common.dtsi
> > because eMMC will be removed from future Meta/Facebook AST2600 network
> > OpenBMC platforms.
> 
> Please squash this patch with the subsequent two patches so you don't
> break Fuji and Elbert across a bisect.
> 
> Andrew

Got it. I will take care of it in v2.


Thanks,

Tao

