Return-Path: <linux-aspeed+bounces-3437-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13FAD46C0B
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Jan 2026 22:41:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1ch72bhGz2xpn;
	Thu, 29 Jan 2026 09:41:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769606870;
	cv=none; b=TLUXUxtmodF/Z9ZiTUi3JhdidpL+7PmeB9AJSt09Okn5sV+nRKTEtPLRhUfesUZY5wcvnb/MRaOflYFhPH3i5nTx2aXBdfayd+6mga8KZMjQWx22OfDCTTQdE+0gG/dH8XFGzgEJSyxqYpQvxsB0F2JEx0IY0qIeAX/XQvBguG6SpE7++Jq1e2o95GrKjhOTykSF2fQMX3kq1TVBJqJWlXcrkdEAwU0155oshcjTpMsvp42GaJecoBx7ZTtQHYBw6dSmgMp7rWTF0jL2YBKLffQEdDoyjMjqbQJWhXMuOEYkS+eRX7mSdrQE4JzbpkE1ANj87JVBgjTl0ddUgfsTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769606870; c=relaxed/relaxed;
	bh=41MXFfWgnOshyB3yHARCHCB6QhMvFSayCiwgerFf9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cBsnGklCCgbhz4+Ke57aAROF0CsfrX233X6sN9mzASEP04Ypwk8HAukWtX0y/xFC07xxanX4PuyqloT6ROs4cUsYngGFhfnLS3RRRGM8WA6TP+GM6Dw8ssysGzxdz6aPclemuVoaERevStk8s+o0RswlVCuyjhdoyk6xMdoVO9LOzO4HQTv9m30XI1yYhHRPN8sA3pjeC0slp/xCRZQxJdd+9LJy6VuYseREMXih71x9e0trPRXaycI8u8qzOLPL55sqrcercl0kQcL/JJHQkbTEw5A/hURJIBQqw1fT/2To7VrHFqx61l5Ew9nfm5OFwbJo6rH/w2NCHoxRBPmyCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSV/E5Vu; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SWSrxDw7; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSV/E5Vu;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SWSrxDw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 67 seconds by postgrey-1.37 at boromir; Thu, 29 Jan 2026 00:27:49 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1NPK2sLqz2xjK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Jan 2026 00:27:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769606865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41MXFfWgnOshyB3yHARCHCB6QhMvFSayCiwgerFf9X0=;
	b=cSV/E5Vu8GdtUNNBp3Va0h5T/gr3eyt6YQ30zwWSJIPd6Fxp0zFOv/4/SMdKOF0rGkeclI
	utfR5R6I/ByuAVmrDbVi+ozaKwTr0TPd9WjVZ+In848OOaIn/9+hYxfZoehspM0wexsPQA
	r8AbCiOmU54OaDq34qPA0a0hQxqHeBg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769606866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41MXFfWgnOshyB3yHARCHCB6QhMvFSayCiwgerFf9X0=;
	b=SWSrxDw7xu62ci7zj0Uvh5ttxUkAw6TxLJEXg7gHedLq3IW7TETTEZz/2QjoP7R6PvcM16
	8hU/TTD43tO84UF/99Cf3WY9ZBfdKqXdVGWxC+HV8V3rdeB3G7ouN5Z6qhYKPIOksODtuu
	dbkzMCLNFs3Rum8tMxDEl+sJCixj+mE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-9vwQCIC5MB2BDxOjo9ivNA-1; Wed, 28 Jan 2026 08:26:31 -0500
X-MC-Unique: 9vwQCIC5MB2BDxOjo9ivNA-1
X-Mimecast-MFC-AGG-ID: 9vwQCIC5MB2BDxOjo9ivNA_1769606791
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c7166a4643so94868285a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Jan 2026 05:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606791; x=1770211591;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41MXFfWgnOshyB3yHARCHCB6QhMvFSayCiwgerFf9X0=;
        b=suVB1s85+uJz30F42KIkL/HbnsNS/v2xOcDLuIo2EaOAAiDEmPMpwHxHtNB2QOz2IE
         YGIe6QgsExamEM+cMAohdA1sS6aeyFOpyyCvrjKDVlaZGJXsBrYR6aNkduIFwKuAmR/U
         ve8Sd3GEKlURiey2d/cwko5hsD191Z8c7gt5M1EoGzfwuQwJvZEM52XIslxkWNpgYjnk
         lEla4hkfkxyukuSXwGbzc78fVlAWieNrXalCnqUY3njFoNAmZV3bsYiDz50y3MyQq81Q
         ZzYhYO708KEaYRXcckMaPAo+YYmar0zUTsRkyI4qy9aORrJNLGc0NGa/rCSrw7rKniNZ
         PTsg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZHSuzVnOxUtNjvYMkOLUuRIO9YenSEfkVdBbQchk393vPVONX8b9ZqfD0rpXijBfDxERQygxFhHxae8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwA52sxLEpSYNv7wbCX/Z1BdIVkibC3jRXJ0n/vUT5Mg8ROQM1w
	DVAJq//igA7pf8J+2aBcXDsrXeFTylL4aL3CQGDAoYCbnnttRHkiAco/20CBnzB1CGh7epD2Ypb
	d74sbcpm2MuObx5e1AqUbX86zyB+a1bt1ZGs/8n/wmFRrtDa9oB6ctY/Dz/qXpzzKyX8=
X-Gm-Gg: AZuq6aJt3uzy22Bq5gAwbAQJtbml/3R37KG24BeX96Ri+VNT1hE9js2h7M4GhDdT4X6
	Fohy6y7ECalP+kr39Pel8nk2K3w7CsLdXISI7lJrpzmW4Q/VyurBq6lXbD+kIMdICC3464QiTkM
	xPRtaZ1LuZyLRchP6BSQ3CJ2l1MRCZfeMW5QHSP49YGuw8xnUcO1kOkEhegCMzBombnrh2IWyUp
	x9E3TI21NhZIR/dKJDLMNrITN94sS2KpD2Lc9zi1mpb8RsDrigkq5FZHeq/FF6ANhjDF8Du+ewY
	7PJxS91rO8m0c02T8PvKyhbjRuBvB6EwJOLUZvL5j1R2g9prVBF1Prynxv8fglUSXcXbH582MU/
	zuMViXvbzsQSnpLuQFHN5Bps3ObshbzUKozpRpsTVPYBH
X-Received: by 2002:a05:620a:404d:b0:8c7:7a3:501b with SMTP id af79cd13be357-8c70b868c0dmr598544185a.26.1769606790684;
        Wed, 28 Jan 2026 05:26:30 -0800 (PST)
X-Received: by 2002:a05:620a:404d:b0:8c7:7a3:501b with SMTP id af79cd13be357-8c70b868c0dmr598541085a.26.1769606790291;
        Wed, 28 Jan 2026 05:26:30 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2cdbbsm176902885a.28.2026.01.28.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:26:29 -0800 (PST)
Date: Wed, 28 Jan 2026 06:26:26 -0700
From: Brian Masney <bmasney@redhat.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] ASPEED clk updates for v6.19
Message-ID: <aXoOgltiXIfIgX8T@redhat.com>
References: <OSQPR06MB7252BF7364580CADD7D3F6928B91A@OSQPR06MB7252.apcprd06.prod.outlook.com>
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
In-Reply-To: <OSQPR06MB7252BF7364580CADD7D3F6928B91A@OSQPR06MB7252.apcprd06.prod.outlook.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PyNjR_mqqTbhllmm6Jwb_t3xPmAY9y5ffhCeozhGZjg_1769606791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Billy,

On Wed, Jan 28, 2026 at 07:43:01AM +0000, Billy Tsai wrote:
> Hi Stephen,
> 
> Please pull the following ASPEED clock driver updates for v6.19.
> 
> The series includes:

[snip]

> - Reorganization of ASPEED clock drivers under drivers/clk/aspeed/
> - MAINTAINERS updates for ASPEED clock drivers
> - New ASPEED clock driver support

This changelog needs to go in the tag. Currently only 'ASPEED clk
updates for xxx' is in the tag.

> 
> The branch is based on v6.19-rc1 as requested..

Looks good.

> 
> Thanks,
> Billy
> 
> ----------------------------------------------------------------
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   https://github.com/billy-tsai/linux.git tags/aspeed-clk-for-v6.19-rc1

We are on v6.19-rc7 right now. This should be for v6.20-rc1.

> 
> for you to fetch changes up to dc345e213f16d3ae5dce01bb0002e46bc4eaff4c:
> 
>   clk: aspeed: add AST2700 clock driver (2026-01-28 14:58:47 +0800)
> 

[snip]

> ----------------------------------------------------------------
> ASPEED clk updates for v6.19-rc1
> 
> ----------------------------------------------------------------

Between these dashes is what will appear in the commit log when Stephen
merges this. Include the detailed changelog here of what changed.

Brian


> Ryan Chen (3):
>       clk: aspeed: Move the existing ASPEED clk drivers into aspeed subdirectory.
>       MAINTAINERS: Add entry for ASPEED clock drivers.
>       clk: aspeed: add AST2700 clock driver
> 
>  MAINTAINERS                            |    9 +
>  drivers/clk/Kconfig                    |   13 +-
>  drivers/clk/Makefile                   |    3 +-
>  drivers/clk/aspeed/Kconfig             |   21 +
>  drivers/clk/aspeed/Makefile            |    4 +
>  drivers/clk/{ => aspeed}/clk-aspeed.c  |    0
>  drivers/clk/{ => aspeed}/clk-aspeed.h  |    0
>  drivers/clk/{ => aspeed}/clk-ast2600.c |    0
>  drivers/clk/aspeed/clk-ast2700.c       | 1055 ++++++++++++++++++++++++++++++++
>  9 files changed, 1091 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/clk/aspeed/Kconfig
>  create mode 100644 drivers/clk/aspeed/Makefile
>  rename drivers/clk/{ => aspeed}/clk-aspeed.c (100%)
>  rename drivers/clk/{ => aspeed}/clk-aspeed.h (100%)
>  rename drivers/clk/{ => aspeed}/clk-ast2600.c (100%)
>  create mode 100644 drivers/clk/aspeed/clk-ast2700.c
> ----------------------------------------------------------------
> 
> The patch series can be reconstructed from the mailing list with:
>   b4 am 20251224-upstream_clk-v16-0-8c1318f56c3c@aspeedtech.com
> 


