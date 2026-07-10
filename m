Return-Path: <linux-aspeed+bounces-4461-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8458AC43458
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Jul 2026 01:01:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyS253v6Kz2yYY;
	Sun, 12 Jul 2026 11:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.168.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783688932;
	cv=pass; b=T16OAig8G3L6XfJZXx/g8xhwlY5kKAl55dafwbNpFMwIldcYuUQEqOSQ691wdlPCe7fzmBySC8+20Bg0UyR73mXgCDES+pM/V91IwsL3G2/MuZR8nHA/bA9WBx5TslVgeTGGxmTQ0x+zDKhOtvuGD5rxZgxmMIsT28Ybp36y2VtkHBsCvqqmKL2YpZxnnXZxJcoAtGMeRUsVkU8A2NpHbLcTkcvmxwagIEkrh62h3cO0rYZJQsP/uX69fK4nixtIC8pqwXkepvEY0LQ+61+zR1huOhxrWSlW87+VjQFPHxcO4NfpMEVFLw1ltq48eM2lu8ryzei+u/1XCeW+eCxSZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783688932; c=relaxed/relaxed;
	bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PksgxjsQeDRhw8bAJDwbjq4VHRWJ3LaUglZVgJ4bLiLgIWcUdp7gT5LAtzb1cc70eum2NWpZz3JxYuzMRMGM5jAysR9ibB9zCQIWHQRxpvXJmZ0w0USjfky17FXhd9g7y00D5I+InlEubgwm/7GoxSpTTPpdT9keRUUPjHmHNKNURA+xZjlVcHBMXUgRBZHhvi4xFB/N6w8ZOlpWdaL/WlOgQt077L8yCAQ1cy+O4G6e42PUFO9HxdviHiGtaigNs0b6lGAcdXrZwnJde0nHD/jzI5e9mpEmbqcpSASBqDesq4cy2LmIz3ZyciDiksUKVGzQfUz8XRhxISnktIhdfg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQbhMoe3; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UsY6iobo; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQbhMoe3;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UsY6iobo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxXGC5ql8z2yS4
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jul 2026 23:08:51 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6Ymh700685
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jul 2026 13:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=; b=PQbhMoe3PoBcb3Hs
	/DihV9aYD7N2odD9vazHqRjsDv89h5rZHGphaH+tpWhsa7+af5rBKTPuJdW8LPZn
	Mk39Wieqo6Mw60r42dLUd2Gxgi7p8bxjZpLshjrj7AzbL34A0DXvPUZmVUH4NX0g
	MgtJWs+BKx0AJ2Ezx5aSRboaeoiSWTe52rVeK8zpfzJ0RAwKpEqAfSYiOKp5qRRf
	EsdJxs0bExnyDS3qhxtop/v2dbSfVm0i9jaV/APL5yQgCnzY8s/Y1+SDeOsMMPGn
	F/+wgSzwHMID5UrcvHdiCAnKRs1pvv9gBeLt9XKdfGXLhg0wmyfSh8mZwn6Udt4N
	ZKZX0A==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8ke1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jul 2026 13:08:48 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6675e8ebb1aso1215744d50.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jul 2026 06:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783688927; cv=none;
        d=google.com; s=arc-20260327;
        b=AuxzZ7KQpy4u5P6y1hjdU9lMDkBP6vmavDK3aM3OTDbycsaqZDG7a9XquVjVLv+Bpu
         DgfcRHxzv7ats+bfzvyGlwmlu0JoGhFtyNOnVHHxWtspJmJb4qfOUh4FwAI5ZTM489yl
         BToDrIhXDvkjr+1SEFjCpDFffTBjgLWm2wYSME5P889nwVCBAaM0QXAGnVP84VbMfXFR
         tsjrpzK16kE5o9KNGXFJFEOcg+ldlr0Oqy00sl8PlL0C68XvUzuaNY8+a0L2bDXJs5oe
         DR2/fIb42MJlhYMoi4SWnhgJb2CNJyIm26r19I01ZHlYEnCOe/AAayIJJa4biopOj1n6
         naOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        fh=WU1QetICZpjoe8rchwhE2gPPt3growVHuXxYkDgaPzE=;
        b=J/nDLx2tqhdLgH+jcSRBOwn5FnNJu9VXF+hMhlHmVugZpezTl2uz5eZ4/haefwHZAb
         jAJqvV3pHwmcAnkPN7UqUOFsF6OTNR/wU5vfba2lMiywbIS6xinO01dVfz5uPWJRq+Y0
         oXl44B9IybrOPrCVKcYoknwf29gpfnuIlx6Hgk4rwpX6kKz8m+12jE5A3ewxuJTT5h4u
         L/ku1juVP5Z6thtBCbGQ5VeyQ9kUBnOM6RW6WdgXaHgV1ttcu6omdPKi2PwAiq9O5NMi
         onw2JkaTzXHqDMJj713owSawnLYkBIOGukVe2MhuBwsEAByKfJHhBMqMbKeCcRH7hWr9
         ED2A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783688927; x=1784293727; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        b=UsY6ioboNaBLAzh9EpcjL2NTiqQf/ORLD2j3lzhFsrJHJRZwU41GrdEh3det1GPnPx
         ZaVY9hnhPn0YfcRmUi53x3+MN43Q9OicnAXbLykSbsPM1t3FLjqxQAixP6zI0ahIEhfw
         6vh5l+BWSTZGobEOFg7oDYgomlpTXRCnu6+7mQQ+vB+vXyPWhKUROns2C1cfK4Zg5vcw
         qzlZCiXbzdEiw+juEo7edO2INK9gjQXjag/mtTyT2IcWXBDESa94muYFWEsxz7ktNE0Z
         wFrbmGh1LDZ9D8KU/anreX0YdXa9dxoQuSFN/vhxTijrFvWRKTrZH+DPr0Bon+ORjsql
         wtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783688927; x=1784293727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        b=RqcxqPzayUPJ7kGNowIlGBc9gSdnRYCMV3ZQrNc0FapOsoKTuOF1vDwGK2hePHgfaI
         l5f/Q9KVZD6vTSokMDT7AqQlSqhWvAWsPMh5xdaYJAuk2TlU107K8Ggh+moTwSsjsLqQ
         ak9v2Pw0qqRJFbFWRLFnlosIITAtBWLOcWziimxciz3UKTLIg2KqNztPVl1V086Q1lfO
         Z0PCmQ4JrlCd8TrGjQ6MkQGi/5affVXnZBrSjcjhxGNa5Sd8IOVzqjOvCy7KGt4y0Itj
         ZlufD3xKNMxy5nUJIe51qkTvi7V7AABOx+tBwurA+cEAHo24OSW7tNTDnIVBAwUTwOvK
         IU2g==
X-Forwarded-Encrypted: i=1; AHgh+RqmOCliAG+zxjpSNxS/vfJus6poxROcPA4C20ZJ3TWiDeFKPiboUKq4pbEVXuxpqK2s6Pj6nTRcbTCJJDw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIQrBZ3rGF4kOcHTVtdeAe+wLYKB687H+nBUvrPx3EDYYZ6NbQ
	vUxg6ZnMuMkwg3omWNMQPhEaG38ajoQ1qA9T+JNh8fH1ChAjBZRR/d8vEMEZokjtYrYSwPBeBR3
	8LnXKyVMOMg/i6Z6/1DmjkT5/uhg2ikZCvSh05sS/HPL9KO39B8nyMD9GaSijauzPTtmYXD8Psa
	9+xR8mY2jwM/sX9oKWDYr2rWViYFTE+gRyZDBe50MsJnU=
X-Gm-Gg: AfdE7cncBwiW7wBsa+VPcUHHHHWQUzPUlNb/FmQ0af79mfDU2NwzUPxowwBMm1+cJoc
	42JrdMtjdx4rFByvPDuSCELDINF/8j0R4rTkD0WLf9Xi4riKMfGS3hVwhEK1bdwgLglvDk5dG6m
	F1IJQb5CnTV7bgQbQjnJn4rruWYC0KU1Xc7SVhFhTc/UZZsViIYY0dCsXtSqv5VycIddnl
X-Received: by 2002:a53:bd08:0:b0:667:8b91:242d with SMTP id 956f58d0204a3-6679f245672mr5946041d50.92.1783688927304;
        Fri, 10 Jul 2026 06:08:47 -0700 (PDT)
X-Received: by 2002:a53:bd08:0:b0:667:8b91:242d with SMTP id
 956f58d0204a3-6679f245672mr5945969d50.92.1783688926691; Fri, 10 Jul 2026
 06:08:46 -0700 (PDT)
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
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com> <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
In-Reply-To: <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:08:34 +0200
X-Gm-Features: AVVi8CefhojPUiWasaXCCjZmJBb6K9Qzlv92c3u5BPoEMYadIduP2fyzpl9La3Q
Message-ID: <CAPx+jO-hkYQoEOj1Jrp7sn5HXYTDbfAG4U5rpNBW2Wue2TZxhQ@mail.gmail.com>
Subject: Re: [PATCH 23/42] mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: O0wodlzz58ZaNBB2ZyBIusSnyRxyVQXw
X-Proofpoint-ORIG-GUID: O0wodlzz58ZaNBB2ZyBIusSnyRxyVQXw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMCBTYWx0ZWRfXyoEu+htLoGSC
 f0lrh5SPrIQN9tTT8PnZr2Z7QJ35Ye4tSDnFwdHV+xOfjpVz/ihqrfe1LAIJ7O8dei+GYrkeFjd
 bgcNYuM+2C+98wAdwXRlyJRJzJ6Bdf4=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a50eee0 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=z_eSG8vRrt57AjWXvbkA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMCBTYWx0ZWRfX0dx1IrkCkBHQ
 gW8IoyJCKGsxGu73ziBfL9LeGX0d61HUvp5jilOhwZ+7Tj2IrRjEww3UzJvxnvEv3brMoYj1QnR
 u9i3K4fKfNb5iGI8oBhdkFeRnA0LiHeUIFMW5B9HpMihB16QBgw2dFwekyw2L+JB+sXg997vpXn
 AgzjHWoLR7TY4UaCXs3hDRpX5x06WJKuA8BNt+jYUnrGycr3M2PRsZGwMsfA9Ln+n5ml4E3mBiH
 8Z9GzFoHhL8W8w86SPxEQPEjUrKEl7txltDnoT3Jr7FMEednBAKLORTyZ5oW6/DUD0FztkIAVe7
 +zua6MDHgZkXzGlOk7lOMHVbEDBDsB0lC/tmIEiVG386HmPcIk8KkM6YaHpfMcYfjLkicx5BkOT
 J6YIGjCkSmi3K4E7Ufy/TjeVSnnv8YMdVsgqy0fIhOgTgvr4AaXqaNVPmjX2//Fb5xb+LXHvkmp
 NL6/LAAB5RAjL48/oZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100130

On Fri, Jul 3, 2026 at 9:48=E2=80=AFPM Mukesh Ojha <mukesh.ojha@oss.qualcom=
m.com> wrote:
>
> Use the devres-managed devm_of_reserved_mem_device_init_by_idx() instead
> of the manual of_reserved_mem_device_init_by_idx()/
> of_reserved_mem_device_release() pair, letting the device resource
> manager handle cleanup automatically.
>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-bst.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-=
bst.c
> index f8d3df715e1a..304554ced690 100644
> --- a/drivers/mmc/host/sdhci-of-bst.c
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -405,7 +405,6 @@ static void sdhci_bst_free_bounce_buffer(struct sdhci=
_host *host)
>                                   host->bounce_buffer, host->bounce_addr)=
;
>                 host->bounce_buffer =3D NULL;
>         }
> -       of_reserved_mem_device_release(mmc_dev(host->mmc));
>  }
>
>  static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
> @@ -417,7 +416,7 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci=
_host *host)
>         /* Fixed SRAM bounce size to 32KB: verified config under 32-bit D=
MA addressing limit */
>         bounce_size =3D SZ_32K;
>
> -       ret =3D of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(=
mmc)->of_node, 0);
> +       ret =3D devm_of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc=
_dev(mmc)->of_node, 0);
>         if (ret) {
>                 dev_err(mmc_dev(mmc), "Failed to initialize reserved memo=
ry\n");
>                 return ret;
> @@ -425,10 +424,8 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhc=
i_host *host)
>
>         host->bounce_buffer =3D dma_alloc_coherent(mmc_dev(mmc), bounce_s=
ize,
>                                                  &host->bounce_addr, GFP_=
KERNEL);
> -       if (!host->bounce_buffer) {
> -               of_reserved_mem_device_release(mmc_dev(mmc));
> +       if (!host->bounce_buffer)
>                 return -ENOMEM;
> -       }
>
>         host->bounce_buffer_size =3D bounce_size;
>
> --
> 2.53.0
>

