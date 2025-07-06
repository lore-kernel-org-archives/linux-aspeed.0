Return-Path: <linux-aspeed+bounces-1640-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9103C83F05
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:12:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZYqK0d86z2yRD;
	Sun,  6 Jul 2025 14:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775133;
	cv=none; b=NktIm5ZZ/oAcDB9Hv7Lqk/lS/R3/j8h8qNtGP6+EUht71i8VNrwtYRoJ3RBXWF+4ApBWQhrvMYyivbG6U/T3PBYAuerU5V2KPrmu6bQsRPFQDVcyGzGPgyMUfrInijXvU5yU8dkp/WAs/yOXQlprdCg9sZ9mWvrr9gCCKvuMvBR9+R7lSUmu44aVtsiWt1Rd6rEYNT1KlvdP6mHwIKDexwdiJqhIo60+FOXqiTjR4+Mgd4FwuiMVLllSjIVhINBd1ma2xQliXvprsh+d8hm/+atLSI11LpLGLgQXFLqb7rOdTrdr57gZ+Rrlg/9+lXFWLEZExgl5IDkg+Aoa2pb7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775133; c=relaxed/relaxed;
	bh=hVmb8+ym3rIBDL7U+LhviQ6wlTsutcclIyc87Szy4qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jicZV+UYLMdeu/HSMvsrVJfNtS7FvV6eP32VZmaqJUisqvbd9SeWCpQkqosdnzm5TjmgcATXGF5c/m79fmEkLDq+tsgqDRU4CT3UZVyzRk7KWp5kJe+TZ17wdcMt93K8f+Bc1W80qu81gtXVm/Pt7FgYmqMKZPkxxaAXxEwlq6JULLeFil8BchfXEkAQjkDTR8bpqJ8KybAXsqIUL286M4hQAV0gGTKF/Rx1UPHex4ZAJeeSSRvyC1JKTxMlDiPJpZJ3ZUEINaMDUIPuqHNAKhqptmqwDSanNaQbcV5Q/HZFuna3KIRepzAdaoH9kXc0F9WO5NyeLkt3f0DLmoaW2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CHj1AiVs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CHj1AiVs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZYqH5Nwbz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:12:10 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-31329098ae8so1555118a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775128; x=1752379928; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVmb8+ym3rIBDL7U+LhviQ6wlTsutcclIyc87Szy4qU=;
        b=CHj1AiVsOv+RQJTIkPSlNQw4Zq3OrgkBl1oAxfqn2qHwSM5AmIRocGX9GJpctbK+tL
         9cLwpcr5HFs4Pm6np2JyufubqR47byn/J4GrMaDAd4ARcteZ/Oypd+LiNhAvrvNMp+qg
         FbDln/reTndrnTsd2I/y6wk+uyEK+zC/PAfYMK4WUKIbR11583W+j7SLpK99uQAsoGpG
         127Cbtun4RD7l+TVFt1jJuh3ZADasfPgy8PKETupMCRhtBvrQjqlE7vGKJ2nKZ2JNAv8
         rvkc345Bsb1i3ypevJbKNxAqjmHrHMk3J1cpROUNU3mHTN+d4YZ0ZJzh5R0TGmRvLUN2
         o5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775128; x=1752379928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVmb8+ym3rIBDL7U+LhviQ6wlTsutcclIyc87Szy4qU=;
        b=VFASyNq6nqC/YIFmUROYg9bI87/V6LCyYuU6V2L9ddqcueZ63HdzlHf6zFkaRzCLvv
         lMRwThw0PLB40b0e/SOSvagjN3QLFQL36sH+uI/BJ7uAQ+xO7fP/EdBaePZlvssruoul
         UM2RVQ1e49LJBN7jE+XgdsOLYnjcWbEXo1HNznwpi4OQ3Gsbmtq3XvZ+P8y2UCvVwcwf
         VP1F78fXrzyPtw2eGPD6hQ8SGFwJRHoq58HiRciM5v4OkD5ztV38UvFP/qQ/WCvL76ZN
         iX3+AHiGyE+Te5XOhzl93VMftIoMLBz//GKgfjYy0JuGlqzlt6BgeD88lnBOQpvXn4xu
         7k+w==
X-Forwarded-Encrypted: i=1; AJvYcCU7va4SQCqMdzkUaXkXoUDkaFO29SQ6p6rRtoaiwtRwg77cn1/jBe6Ljw6TDH2cf9xyxa1so+PWIxNU7Sg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0jyEDfC3CdOi6tWs+umkwzmsXrRESto5lvf9y1zCKlZr9328K
	VZNjBeIi7GuZZdt1WVQsQs+iL6OdQ/BTNw5Oi8NQzF1G/Vw7Q3NsREpB5siJzDjA
X-Gm-Gg: ASbGncu19LBx3ZaO3hkb6QWVMhYb8RwUWtTrHOuO+zfwlb2ANzOw2EG2LwRO73fZnel
	60nTMb1BXFrJKJ4z54hin9kiMXs6zNcmBiPYWNDp6BOLjs3lRrn9Se6z8PZ507BiCjnMvrLObbM
	u8kow8oC79sa8s0hDJlkRXDSrxitu0LZzDFIAzhlxYth7ZefxUeJ/gfBcyxYynzaiOKtiBAmOs9
	74oNHq2FZ6qK/DSsBJkeFBkenBZ5RG+386JhpaA1mfHf94sUsFDO120A16gdpScm5/HWBx35P+7
	retK8gO0EpXxJwAJetW2NpRiFdT0NWKgJDc187O8Sx4EccoofNF4RF/OvkDXCfr9zzjrPMhSflX
	Qn1GJfYKKbBbc9f9YfIGFUfMA+o3IOTJcFyFVA9E=
X-Google-Smtp-Source: AGHT+IHvXW5jZXVYlEka38PzKTBwvT3r/GnGzZfU2rZK6jmJT69dhrpF0lmwPqysm1iag9gx8vKZWw==
X-Received: by 2002:a17:90b:48cb:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-31aab83725dmr12052060a91.1.1751775128288;
        Sat, 05 Jul 2025 21:12:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f34bsm53310255ad.156.2025.07.05.21.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:12:07 -0700 (PDT)
Date: Sat, 5 Jul 2025 21:12:04 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <aGn3lNXQ8cid6jbf@localhost.localdomain>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
 <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>
 <aGW8Nm8ZWMwRYVOo@localhost.localdomain>
 <220ac6c2-8373-4742-86fa-f322d6ada624@lunn.ch>
 <aGcBEHMEyQJuzmjj@localhost.localdomain>
 <95ff4056-d1cc-4564-8c44-0535196e7428@lunn.ch>
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
In-Reply-To: <95ff4056-d1cc-4564-8c44-0535196e7428@lunn.ch>

On Fri, Jul 04, 2025 at 09:37:20AM +0200, Andrew Lunn wrote:
> > Hi Andrew,
> > 
> > Got it, and thanks for sharing the context.
> > 
> > I will reach out to ASPEED offline to see if they are actively working
> > on the MAC fix, or if I have enough knowledge to work out the patch.
> 
> There was some discussion about what needs to be done a couple of
> months ago. Look for emails from aspeed and IBM.
> 
> 	Andrew

Hi Andrew,

I guess you are referring to the discussions in patch "ARM: dts: aspeed:
system1: Add RGMII support", and I can find more of your suggestions in
the thread.

I will remove mac controller from my v2 for now, and will add it back
when the delay support is added to the MAC driver. Thanks again.


- Tao

