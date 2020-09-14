From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Mon, 14 Sep 2020 12:04:53 +0300
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <CACRpkdbrrzkYVW13V89PJ5_WRGhxSL0rOxAHA_7hYSyw28Shvg@mail.gmail.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
 <CACPK8XdocAX5mOXf3VP29cNXH+6unYunB9NiT3qFVKyzR6WXPg@mail.gmail.com>
 <CAJKOXPe6Tf0B5W27XaD5zLk77OBzGCHpirhTdZjFH0oh8GvWgg@mail.gmail.com>
 <c162b6ad-57f1-a75a-11e3-9c80c60bd845@ti.com>
 <CACRpkdbrrzkYVW13V89PJ5_WRGhxSL0rOxAHA_7hYSyw28Shvg@mail.gmail.com>
Message-ID: <1d295310-880a-0ca7-273b-ad07f1a0498b@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 12/09/2020 13:07, Linus Walleij wrote:
> On Fri, Sep 11, 2020 at 11:54 AM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> More over, there is already generic schema for gpio hogs: gpio-hog.yaml
> 
> Where is this? I don't have it in my GPIO devel branch for sure, and
> it is not in linux-next either so not in Bartosz' tree.
> 
> I did suggest that I want a gpio-common.yaml file which includes the
> hogs.

There it is (am I missing smth?):
pip3 install git+https://github.com/devicetree-org/dt-schema.git at master

as per:
https://www.kernel.org/doc/html/latest/devicetree/writing-schema.html



-- 
Best regards,
grygorii
