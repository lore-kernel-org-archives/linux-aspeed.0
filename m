Return-Path: <linux-aspeed+bounces-1620-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FD4C8303C
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 23:13:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXbKx3Wx2z2yPd;
	Thu,  3 Jul 2025 09:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751498005;
	cv=none; b=Ke1CpjZjUoM001LtDB4FFmEGlgonkNrOjsLdo7YNwzFLg/PvgS137OINvv5CTRZfD5wGKuIiOst1Yq9cq4tGBNY1fft5p0Kb2HLGmXdKdA2BCnuG5eRSjJ2/PXqNkxdi38QW9za48KJg/t5NZXYHRXOLaYD4vUbQ49VWAvMz82A/lp+kMJIcXRYxcmMn2dgP5dqi1GyGtDQMS2xrkc7jT8PEMTjITh63RHZn8Tux8SZQbCBvw7pYyiDOWOM5ZK7kWtgn56IQX5IEZhLG4AwI7zFUEIYLtuqq5FVSWXc6AZ4UNyTpDCZXydYj9zWWeGk74QXm5JV3kkpMaEvwOjGcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751498005; c=relaxed/relaxed;
	bh=5q1f6Ouy7hbjx9qckWIFtBppIrqabDs5gJ+JKIQOaiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCAB6HegU07KxkG5mIvrOk9oBdssIOXIYip5reQxgwZ6OLNDxgFK07LEqEpiaNeSwFbrTfHBcBC6qLfTeq5Gys1R7aYYugM6zwddang0pA6TfvA77anIzMbuG0+1V/Hab0NFbgDFELrAWk8pOrN9m+14oDWNwxNT1xCGBEhf4sBq16piSaDa+KM7K1IyuYGHC/Pd1Mny4pTn+VkFzqliwvWriEyEXI7kAp4a4tu7mhesUo3v7vEKi+aK6hMxrXRKgjxh06yc+foyIE+5blh2aNxV5j47h5BAmESWhaGG9Td6I49WFZ/Ner+lMMAQqs58y/xf2NLS9y+vNzpTXVnFuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h+DcJoms; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h+DcJoms;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXbKw4CySz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Jul 2025 09:13:24 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-748d982e92cso5567641b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Jul 2025 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751498002; x=1752102802; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5q1f6Ouy7hbjx9qckWIFtBppIrqabDs5gJ+JKIQOaiQ=;
        b=h+DcJomskJiARmsjGn/j0zVqSTKDeYpRmHdyTJw020WSwB4CJ0c0SxmXoiSj4qsypA
         K5ULeM3TzKuWxie9+Tb1svODfCU7pX8CCWdG/q1QAuoR3WbBYcOuf0NUZka4cYVNCwrc
         c7YM2dj+V9c9Qpu4Qlaz8gKWuCyyx85bjmiMiX9z2SxvmO1OnK+4/ukRDF0BSvtSNdKg
         8eF0kXT6Q+jik1aVKaA4mMWL4VRRFqgCcn8N2LHq2CurYhrAILdTZ4iv+5WncpeYnOH7
         0XH98yWVpfj/3JjeuoFIYA2WsxtBGc4BXl8bFNstbOShruUk30PzHK9XuaOJz65l3F4o
         EYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498002; x=1752102802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q1f6Ouy7hbjx9qckWIFtBppIrqabDs5gJ+JKIQOaiQ=;
        b=YEPW+2EW0UzadE3Y1xGXCLZ3cvoVLWAwihZlGzTz/GH/2Re5anq78Bm7eT0XjtKIsa
         SjrMnrrtuzzR6v6p/uhKYmB5JjUXKw7It7Gat6kyAaIEdvt55f6QXuPV2MA379str5rA
         zGCNQdcxXvWYPYEOMaZvsBuQkQxcgCkr6TvmTYmnHDxe7GHs0STyvFr1Y4Ttk1BSvkd2
         zs/9kKgkD/SBMueuhT7iRg4nD+7NmwL+8yUHaU972ZCP8eOuVc9MmIL9OslGUNh7Ivhf
         t+HkPKfZiPRjI8fyNKDoCAqyQo5TNwuuVQnQbQlc03yjHlsIJetNEyHWRoEliqqVfBNJ
         BfgA==
X-Forwarded-Encrypted: i=1; AJvYcCXESntUPOnEA1dNcD7NqV2ZVGbIX4uqgvaC9x/ovHNyUcAtGPzzRzCRNxzhm6OwNMBmf34IPn9Va7iAjKc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoYh4owTr0aL9Uk6Wom2CwKNZH2zLomEgVsu3q9iwI4kgZiOnx
	5jzpvg68abiki99b5Q7ObNhzXr0lsszNlQutvv++Jy4J6oQvcS1lPP3p
X-Gm-Gg: ASbGncvz2e4972N3uoyr3envS69o5f6z4HujqT5itWVnW9cAZoyaC3c+MJodk+4y858
	5SGgrWO1vVVhjS9P6OLbXpflx2ExayomWyjQSmcRu6n16KW0LyfgnrcCQ5/Qho/55xigHPnvuwJ
	WCEwIhXQ+8SCF3H+hz/1t/yH7nNKi5PR3ZmW57DrrC/m/wyYoPcNGwBtaP0WyBsAM1u01k4H/mx
	P5tuy+nyAXcLRzuOo9bmlykzqB5X8XIWH+IneAXbZ+ovTTSgBGt9RqBMYH7OteCD74+DmKxyaBZ
	3hKVsnUdEwZhnQbK/RZEqc1/wWrTOvzR59TeIyFV68qnmJY+6GiuvQz1OPwdlFoXVPqyQfbTFdg
	GvbRFJCdzW3RDXNATNRuvKK/6TJk8vS8RZ5OfZY8=
X-Google-Smtp-Source: AGHT+IHle8eoISP2qCXEJoMWIftmhm95QoQXG95iollb4SH97ajP9LpfNKXbVUJ+LNamKOS8iN7+RA==
X-Received: by 2002:a05:6a21:32a4:b0:21f:50d9:dde with SMTP id adf61e73a8af0-222d7dcf414mr6544906637.5.1751498002261;
        Wed, 02 Jul 2025 16:13:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e300994asm13788791a12.3.2025.07.02.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:13:21 -0700 (PDT)
Date: Wed, 2 Jul 2025 16:13:19 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <aGW9D+xO1NaDodJX@localhost.localdomain>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
 <34b0f5e2-0341-41cb-8915-8f1606e14827@kernel.org>
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
In-Reply-To: <34b0f5e2-0341-41cb-8915-8f1606e14827@kernel.org>

On Wed, Jul 02, 2025 at 09:50:56AM +0200, Krzysztof Kozlowski wrote:
> On 02/07/2025 07:04, rentao.bupt@gmail.com wrote:
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> > new file mode 100644
> > index 000000000000..f902230dada3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright (c) 2021 Facebook Inc.
> > +
> > +/dts-v1/;
> > +
> > +#include "ast2600-facebook-netbmc-common.dtsi"
> > +
> > +/ {
> > +	model = "Facebook Darwin BMC";
> > +	compatible = "facebook,darwin-bmc", "aspeed,ast2600";
> 
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.
> 
> 
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thank you for the detailed instructions, and I can see the warnings from
my side now. I'm working on the fix, and will try to send out v2 by this
week.


Thanks,

Tao

