Return-Path: <linux-aspeed+bounces-4679-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0516C5B570
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Aug 2026 00:14:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJsYt0skPz2yyx;
	Tue, 11 Aug 2026 10:14:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786329743;
	cv=pass; b=DbvMPJ7gJ7Mts52CHVDT0Sit0G0ymYD6K128W+4W5PRC9gW564jYz3OW5ceRPezPmh5OLeKzKTGs1TSO7gMBWw4QsBrjoMhAns9a42gVJVHF7Yexltg/Tj6WJ8O6Jnn8VB8kLWdwyuv16IFaFpkGCk7M5XOEMEtuG8pYi0pGvtUzShIGCVhA8J67JslpfXoTdz7Bh65x8Vx9xZKsIo4pPiDIEeKMt6BbIA1MHrOA00nX5qtIwGh9cs0QNqhAYOtW+Zy9/Bir+F761YBAY04VHtqfBNtoPD0wKUL2+GHLpPXkf4VuZpfYJvIGFs/h0od2tXtL4gLD/jCUUXLLfXOIEA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786329743; c=relaxed/relaxed;
	bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4HMp2ffXJOdmqOjHtwA0reuHPlOm56dPnYZbkOXe/3//KG12KNxr2f2lAU49LJKWu76BpUlbvs1Nd1ysUVk/kY81CVTx8LGWnmpFL2nmLdS9lVCcU+Fof7OoddR4674t3jS+w6CJKTPNLeGPmnwZGAp9yLmqMNjcx1QrYDoZo38mkTD67zHd+zvZL5PZXOK85E6IplwSb3Q1nG5rUkGYI2T5AUq/HE7OOeuL4g+fUGmAY6thSYZjIy7xHDIaN784fOxmWf524ywPqPSniGZoc9p6ud2bgrDR77VBa7VPO0AaeC9Nxawk/3QEq3Qss/JEiyVrY+D/QyVqSForYlgqw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fi4wkdMM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fi4wkdMM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJJv16T8rz2yqP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 12:42:21 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso1348450b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 19:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786329739; cv=none;
        d=google.com; s=arc-20260327;
        b=iMgoY1lY8zoNceDXOsHSqzP2q0b9g24w0aQow8cDREsKR7yG7gOQV+D46kGP5MBf4c
         V4Ca1MKPnwCCp9F2XV8+jfHwAxpg1IUNily0+tryClWfNHzt7sw1Q1e3vdfsuW86i2hH
         UIngTJCSwPIdYVzKLE+E/wn9Dxewqq0xcMEWHJ21LPKCky62ZlcQlNvhn7wmVnuqFFv1
         dQDuffio13Wdg0wGFPXpeLUtzPZSMeJrI7bDwCvmoLoo/VKHPPFXcsq9lfxzZjVhq4Y5
         SYG7imnysozQJY7uHStobFZJunaxo6m2gG3EddzfVTb3RxIM9gn2Ei7F402LOpImtkkb
         oHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
        fh=oMAfUEcQw0DibRDFO+aTtd+Q99wskU+ID1q/AsLV4Ck=;
        b=HhsWK7GB2UMDejF6m/4PDb7E5fSSysdHYSO28D0mfDVJkh7zHViDIH38FI2JpLSvFq
         gERgonNl0QVB4hX/ob9aOXBmwcibNIwCfXCGswrEYku6fZl57YY38W6/+mK7FGBXKj23
         AVSVw0ArObnFViMV/Ctf79DcXCrGGcoLBPEsfBCiSxj1U4VJjPfxJUdmIiW7N/HLPQ6d
         0Tusoli/bGIan7SPQg+xZHSH6mqD+8F+BRgPoZlTBeEIiun5HTt4unX4BkvcmnM/b643
         IIlB3b57lVXljDyEZBArjj41T6Y2p5+HVmQ6OjP8VKAIUR4nYH+pZIgBr6NFepRfRTBF
         iweQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786329739; x=1786934539; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
        b=fi4wkdMMFdyIq2nBx/5WhzRJBTrRvaSBHkfDLlT3QvYV0s64NVrMZnfJUas+Q+8Nvy
         3staiigKUMPtdn5LBnmKtU+tYJ+54maLA+niJ2kM/N0PthD+DuX3EbYpFDIrSYlwP2g2
         ydylOkcX0mp//HufClA7PWpt2QSB3BqaqfZpbVDi0/9mT2rbRvmQxy7uujD90xtsePKW
         lCheGw9AXeVIPzVPlPpodFzcZEDKMFRhryz58kXeB/OoCtNof76Y1OVKgC+Q0YGo7fWL
         J7pCUEoQPHJDBQB2ckKBil3f+GxWzj/sOwh7+5zHL3T34pNXEAFeli1ETq9UYmZIbBfa
         o/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786329739; x=1786934539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
        b=i58XsNVak/+ISQdVPgYbINtjNcaPAG80k4wJRRYzn9CFwzq36ddkMsQV0lOE4DNZB+
         DCW6K0EJ9YZozILfNNGH1ZdSEeUkiNPP2hLuPP31nA+9vOxVzUNGMWVyu60CP/q+gXWo
         dl0KUREBZJr3dHNFbHHTTn6k6bhZOH+Fgh8ga/vaGoeT34rBmx2WGH6wZ7g0FyGGqXkE
         afPMcT9LPll1Qf9ExNAqgpfl/91RGaLRCKBZD/aNsWBx17T5fMUsl3958AIc6Pu5CQ8d
         ipiR1E6bhmsb3DOCH2NGFOVEWpf9R5LBTp2iX3YBo1jaNuiGK1ConX9Z7nBtOuGqzMYw
         ZWrw==
X-Forwarded-Encrypted: i=1; AHgh+RpRauMOx+N/OzAUp+nHb+rhl1EODMxoeB9rm4Juyx9e7leCH/1zrtoz4mh+VZcomBftgEDYx2/Kfm6LZEc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0j2vQUIs8koN2uXcpELDwWjifVpOMv1Y75k3eGap/oPsCf4l/
	c2IVSkjCucR2gUZh2Fuo99RGwJViO9fxbRTYG/HCK8zgcI/ZEcUyHArXFqHjXEmseLYPcDMTFZG
	e6efK/od90rqBD7fwC4F4/d2lgokw9fc=
X-Gm-Gg: AR+sD11mUq46nGFBCUpcilUinGCYwoD/IOt3XVaH8yTXRp4iLwQeUEC68spnSyNBrDL
	nIOH2j5kFFlPPNIUlqPNHFnghLCcd52q1gJLHwrb/9/I1W88wbrx6KgUY1gmH955iDi/QXO/See
	2xAxQbi0/8u9SJRbUpzsOn75OI5n22IqKtaZhkhV7TGszuIJxXNG9VEKhrkk+4KakcMN+1POwSo
	Y3ZEI7zo4o5ucwJfbkXI3IV8cNX1hUHGTiHXFQMTE45OLBeyV/sxZGmmzPNVrLkFNc9qrbFsvqI
	LCV+gT05zRAEVpNwdp2yWZHtD9pdoEdumN2ubVoS3zT71bJdhWcwu7lZovY2vNsbnV7gyJ534N4
	dah879aAAI7hBMGPl6oOMu/yY4cR303RlXBDKCjgSO770d6j9JBUPluNs
X-Received: by 2002:a05:6a00:1d9d:b0:848:469b:3d19 with SMTP id
 d2e1a72fcca58-84f69700138mr18901107b3a.29.1786329739493; Sun, 09 Aug 2026
 19:42:19 -0700 (PDT)
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
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
 <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net> <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
 <ccd8fd7d-4555-4ac5-ae73-c16e98b8edc8@roeck-us.net>
In-Reply-To: <ccd8fd7d-4555-4ac5-ae73-c16e98b8edc8@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 09:42:08 +0700
X-Gm-Features: AUfX_my6zYcbzcH2Wjjxkf8uek_ej0039cVqQTNpkObFSyVFxGT4TjQ-70scvlg
Message-ID: <CAABR9nEGsisuuQhLwxdcB9i2sEuH=AQb3yaPHPNecya8G_5ieg@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thank you for your feedback.

>
> I wpuld probably implement something like
>
>         if (data->pretimeout) {
>                 irq = platform_get_irq_optional(pdev, 0);
>                 if (irq < 0 && irq != -ENXIO)
>                         return irq;
>                 ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                        "wdt_bark", &wdt->wdd);
>                 if (ret)
>                         return ret;
>
>                 wdt->wdd.info = &qcom_wdt_pt_info;
>                 wdt->wdd.pretimeout = 1;
>         } else {
>                 wdt->wdd.info = &qcom_wdt_info;
>         }
>
> (which I think would be a combination of B and C) but ultimately it is
> POV and doesn't really matter.
>

I'll go with your suggested approach.

Best regards,
Phuc

