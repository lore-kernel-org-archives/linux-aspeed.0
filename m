Return-Path: <linux-aspeed+bounces-1651-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F3BC83F05
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:37:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZNK5fjjz2yRD;
	Sun,  6 Jul 2025 14:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751776641;
	cv=none; b=X5f0P4PIRaX3hhqKzq/py51i9EuT6iHTdfzhXhGBep0yvWvJIkk1WHzcNPkNvuoIcZg76E6szttDC3LpbMiYZ3MlHhOSc2P8kGODuXD9XMiHmLeVqEydNi5Mag/liyVUkCl4TnI6O2oCbZjzlvMLQ//AWWyyiLVDc5wpuWIIUehedXvUjc1lGr6Y/WNHXppePiIPAUCCk1QGWiXVv0RMlV4EUYspr+vxJMljEKP1/GM3W7JWeCa/xKAMxPts3io7Sp/+d8jvf+5Wor/zrSy6lXO+2v5ZgXP4Hz/+AW23QecGk2q8poqsMkoB7dGMFKfMalaVx8AekcX0boIwk8wkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751776641; c=relaxed/relaxed;
	bh=1y2FRrOTA68hlJ+NjGl+jIRexDC9u6D/zy0MCfqEVY4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br8MLNaT9HdLojwTNFTrpxUoP2GqAXwKckhXzqyciSKk08L5/xnd8M6BL+XTGbvCF1mgZi32EYgi5tnrbtv00TZAX07/JHb0Yg1gSMJRe4ZrASeraaHTG9mN5bwmu9nclvmyg6FmMLut/plV52N188eF6n5u3jLyG1X13Bw2og35TqdVtudhWYgF7FZLmMd10LPKGwHubT5ODpUt1yYtunfSsPCkiF7Ty4HusX0EYEM16qTd/TgRVOqIXl7/idDmR5xd8XEPfO9HGVjnIDiVawPwOzQNJWu5enOaJUUGgjyWgaaXwnRktvoDFJa0FOKADTxLN72b0IGMr38gmtX0Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I1qWK56E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I1qWK56E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZNJ18Rhz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:37:18 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-747e41d5469so2383201b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776637; x=1752381437; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1y2FRrOTA68hlJ+NjGl+jIRexDC9u6D/zy0MCfqEVY4=;
        b=I1qWK56EhCSN2v82D59xL5Y3CVxw1tf5e7ifURSYsDOTkQAS6+dfh1YFdy5m1mu7gz
         VT/7aekJVINwRatfxm5zRJCMgPg/dWLhDfsQfv6QCXT7IQHrg+YNYYV6Y5elEJhuEMjB
         6JfVdJtAxjhdYY8V3o+B8d67WG+rnSBKKJr5Uqyn6JQ2U6fz4RnLhv+syGkkR3uBWzhl
         JPo/r5BEqVQDzxGR74YCMkWGX2xugoJLh4cpNpZZScsRUBfyU9byrV35/jCnctGoE1vX
         mC9x7rGCJN6Sib8QnP+e+HOu5flskA3kdIDDDAZDhVOhOlqYfPNvvdQu6UZnYBd9WE+j
         5zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776637; x=1752381437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y2FRrOTA68hlJ+NjGl+jIRexDC9u6D/zy0MCfqEVY4=;
        b=CxrNMxnOOEIoBRlHQ0C7LplARGW8kVLl6oUnpo5SJuw61+gv/XD8Zf7eq9YfBrBfV3
         7wB5rMmvNp+/2JCm9o82E4c5yCtHMNrOz56vTxDM0lRmtllSLwjjid699a2o5dgPnPk+
         iPnAMGvs+0Xsj6ksYxETEew3oujb0avuLvEy4izMZs0g9QJY9AmalwyTfhw0z8r1R53b
         53KkN5rDOG8T0FO0t757YUyuf3x1oX+ZUGdV8fFUjall2cn5jr0G0uVtSEAdTuIQqDjj
         MzhF59E2l8gOws9oGYNd5iIQ4ZpjVYZrh1+Yy+fHGC+WOz3A6JiqzuYlki2aamHxLJPH
         0w1A==
X-Forwarded-Encrypted: i=1; AJvYcCXLzFHp8PLf7tQm7gLNL/TdHD514eq1/stZjQu2IQY+/nX/UVj21hyz1i95uw/DC8bmlh4JH3OVT3AsD9g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzpNv4l4goTIcQ2ZEoc3xORKjAdyZ1wMYMVOJi3nox5B4QESi27
	D0rnp2/4T4n9Y5Oz/FYHkveYxIxnwbOZs1m/s2eTwx4ocaz+ZU0wC8g2
X-Gm-Gg: ASbGnct+lAZG1iLQhctR/CjyQ5Ndc03v72kuxmwzRF2KZJpP1BWZmLJHzamX22a+lqs
	G6va3KBcA/38QIrEdGBw9ZUfGECch1ZaAWJeTmpxI6LmMMx20WPCmD88aOtb5i+1DHz61jTDU4e
	0Fy6grkynBn4SQRe3P8nqoes/d/AbYzvSBffszvDVRE1/TQ70FDm9YU88NmtpbEj/nSu1jAbFIG
	rNzk1nxM26PuIxrrUzZQhDypfkAJtiQDx7POJ83hattBaIJwg+MHuC/p7Lp6QxgFx/4SVQUaGUP
	/Z/Wdv4tgGp4BDThqC9fTBbGAyRx/vZQR9g0tHhLRBvjmEfkM2HjIBNy7lVtltSib0pHb5az0Jn
	jqKkVZiX2DAlGwiVF7Vdcup8yP4JXNaYdtqvGY88=
X-Google-Smtp-Source: AGHT+IG0ByxlfHWwgJ+AcNjU2yUsaqNnzgD75XgpxrmchkB3mZY7uDwPyNr4YJZ7aw0VrdPW/p4HBw==
X-Received: by 2002:a05:6a20:7f9e:b0:220:658:855 with SMTP id adf61e73a8af0-2260a69f74amr13517414637.13.1751776637206;
        Sat, 05 Jul 2025 21:37:17 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62b1acsm5577847a12.56.2025.07.05.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:16 -0700 (PDT)
Date: Sat, 5 Jul 2025 21:37:14 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: aspeed: Add Meta Darwin dts
Message-ID: <aGn9erhghE0Bpgl9@localhost.localdomain>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>

On Sat, Jul 05, 2025 at 09:23:50PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> Patches #4, #5 and #6 introduces a new BMC flash layout to be used by
> wedge400 and fuji (and later more Meta Network BMC platforms).
> 
> Patch #7 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
> each BMC platform because eMMC was removed from future Meta Network BMC
> platforms.
> 
> Patches #8 and #9 adds Meta Darwin BMC and updates devicetree bindings.

Hi Krzysztof and Andrew,

I've fixed all the "checkpatch.pl --strict" warnings except the "new
file" warning, and I guess I can ignore the warning?

Regarding the dtb warnings, I've fixed the warnings from the individual
dts files, but there are still some warnings from aspeed-g6.dtsi. Are
these "known" warnings? Or is it because I'm using out-of-dated
dtschema (2025.6.1)? Please suggest.

Thank you very much for the review and feedback.


Cheers,

Tao

