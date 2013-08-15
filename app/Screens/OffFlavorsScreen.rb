class OffFlavorsScreen < ProMotion::TableScreen
  title "Common Off Flavors"
  tab_bar_item icon: "tab_bandaid", title: "Off Flavors"
  searchable

  def on_load
    self.navigationController.navigationBar.barStyle = self.navigationController.toolbar.barStyle = UIBarStyleBlack
  end

  def will_appear
    @will_appear_done ||= begin
      table_view.tableHeaderView.tintColor = UIColor.blackColor
    end
  end

  def on_appear
    self.navigationController.setToolbarHidden(true, animated:true) unless searching?
  end

  def stopped_searching
    self.navigationController.setToolbarHidden(true, animated:false)
  end

  def table_data
    @table_setup ||= begin
      [{
        title: nil,
        cells: [
          cell("Acetaldehyde", "Acetaldehyde is perceived in both aroma and flavor as green apples, and in an oxidized state as acetic-cider. In the natural anaerobic fermentation process, Acetaldehyde is a precursor to ethanol:\nGlucose -> pyruvic acid -> acetaldehyde -> ethanol\nUnderdeveloped or young beer exhibits acetaldehyde wherein the yeast cannot reabsorb or finish the conversion process. The other version manifests from oxidation of ethanol or bacterial contamination, the cycle being:\nethanol -> acetaldehyde -> acetic acid\nAcetaldehyde is typically inappropriate in any style, though Budweiser has integrated it within their flavor profile with obvious success intentionally. Furthermore, Salvator & EKU-28 also display acetaldehyde, though in lower amounts. Cold storage for short durations promotes acetaldehyde in the final product, whereas longer cold storage would ultimately reduce acetaldehyde into ethanol — hence the cure."),
          cell("Acetic Acid", "A bacterial byproduct, sour-tasting acetic acid is common in sour beer styles such as Flanders red ales, which are open-fermented to welcome such funk-inducing compounds. In most styles, though, acetic acid is an off flavor; it’s detectable by a green apple, vinegar or paint aroma and/or flavor. Its most common cause is a contamination in the brewing process or your pub's tap system."),
          cell("Alcoholic", "Alcoholic is a desirable property in some beers such as barley wines & bocks, but undesirable in most other styles. Detected as a hot, slightly spicy flavor, it manifests in the nose as a fragrant vinous aroma, warming prickly sensation on the lips, tongue & back of the throat. Primary cause is from Ethanol, though other alcohols may be present as well; collectively these are called fusel oils. They can be produced from high temperature and/or excessive ferments – in which case imparts a more solvent-like character. It can also be created by excessive fermentable sugars via malt or adjuncts. During mash, lower temperatures can produce more fermentables that convert to alcohol. Age may also contribute to production as live yeast in the beer continues to mature."),
          cell("Astringent", "Bitterness is a desirable flavor characteristic in beer, whereas astringency is not. Where bitterness is perceived in specific areas of the tongue, astringency is perceived throughout the entire mouth. It is a dry grain-like, mouth-puckering, tannic, vinegarish-to-intensely-tart sensation that is deduced entirely from taste & not from aroma, & akin to chewing on grape skins. Though astringency may arise from bacterial contamination & subsequent formation of acetic or lactic acid, it is more commonly associated with ill-considered formulation or processing. However it should be noted that excessively-hopped over-attenuated pale beers display astringency (from hops) more so than from sweeter richer styles.\nFor ingredients, sources include: alkaline or high sulfate water, & stems or skins from fruit contribute to astringency, just as too much six-row malt over two-row. In terms of process: over-sparging, high-temperature (above 175°F) sparge, or boiling grains produces excessive tannins, just as over-milling/grinding creates more surface area to exposure. A poor hot break can result in excessive trub; both are considered sources for astringency.\nCures: Aging reduces astringency. Attention to process specifically outlined above is the best prevention. Hint: It has been suggested that skimming off the brown scum material off a vigorous fermenting Kraeusen reduces the chance of astringency."),
          cell("Barnyard/Horse Blanket", "Earthy, haylike, musty nuances; common in spontaneously fermented beers such as saisons and lambics. An off flavor in other styles. Also called farmlike and horselike."),
          cell("Buttery", "A buttery flavor often signifies diacetyl—an off flavor—but very low levels (akin to a chardonnay’s butteriness) is acceptable."),
          cell("Catty", "Musty, urinelike aroma; see oxidized."),
          cell("Cheesy", "A cheeselike off flavor caused by old hops; see Trans-2-nonenal."),
          cell("Chlorophenolic", "A plasticlike, chemical-smelling aroma."),
          cell("Diacetyl", "Diacetyl is recognized as a buttery or butterscotch flavor often accompanied by a \"slickness\" on the palete. Low levels are appriciable & desireable in some styles of beer. It is generated as a fermentation byproduct that may be reabsorbed, depending on process and strain, or as a bacterial infection. Extended warmer temperatures during fermentations tends to reduce diacetyl. Worts with high ratios of adjuncts tend to produce higher diacetyl levels. Additionally diacetyl removal is affected by the constituents of the wort. Early fermentation cooling may result in higher diacetyl levels by virtue of Time verse removal mechanisms in contact with beer. Agitated ferments reduces diacetyl by increasing surface area over Time (rousting), however care must be taken not to facilitate production of acetaldehyde!\nPrimary bacterial infectious causes for diacetyl eminate from Pediococcus damnosus (love that name!) or or subspecies of Lactobacillus ; late affectors in the fermentation cycle, but also may be found during storage of the finished product. It can reside in sedimented yeast, thus affecting future beers if repitched. Both Pediococcus & Lactobacillus are common for Lambics, yet by virtue of process (active fermentation: the mechanical process of CO2-scrubbing), diacetyl is reduced to imperseptable levels.\nThere is no treatment for excessive diacetyl, save for the methods previously describe to affect reduction upon fermentation, that - and good sanitation!"),
          cell("DMS (Dimethyl Sulfide)", "Dimethyl Sulfide is a volatile sulfur-based organic compound which, if present in excessive amounts contributes a flavor & aroma akin to cooked canned corn or celery. Source of contamination can come from \"wort bacteria\", and/or relating to process, such as the presence of precursors due to malting, infected yeast that is repitched, long lag time before fermentation, chilling fermentation too soon, or too high initial fermentation temperature. Treatments include proper sterilization of equipment, boiling wort for at least an hour – especially with canned extracts, & following proper fermentation practices."),
          cell("Estery/Fruity", "Esters are aromatic compounds identified as fruity and estery at high levels, and may include descriptions such as banana-, apple-, and pearlike or grapefruity. It can be desirable in some styles of beer. Aside from the obvious fruit addition, Esters are typically a byproduct of fermentation and characterized by the yeast strain, some being able to produce more esters than others. Higher gravity beers will tend to produce more esters than lower gravities. Aeration at the beginning of fermentation high fermentation temperatures, and excessive trub will produce more esters. They may be reduced with time and age to closely related fusel alcohols and solvent-like acids."),
          cell("Grassy", "Flavors reminiscent of chlorophyll and fresh cut grass occasionally occur and are most often linked to poorly stored ingredients. Poorly stored malt can pick up moisture and develop musty smells. Aldehydes can form in old malt and can contribute green grass flavors. Hops are another source of these green flavors. If the hops are poorly stored or not properly dried prior to storage, the chlorophyll compounds will become evident in the beer."),
          cell("Light-Struck", "Light-Struck, or sun-struck, is a strong aroma that also imparts on flavor best described as skunky or catty, and is a sulfur-based corruption of hop flavor due to light exposure. Sunlight and particularly fluorescent light are particularly damaging to beer, especially if bottling with clear or green glass. Classic examples of skunky beer is Corona, Rolling Rock, St. Pauli Girl, Moosehead, Heineken, Becks, Samuel Smiths, and even Pilsner Urquell. Some breweries protect their beer against light damage by using preisomerized hop extract which are less prone to breaking down into skunky aromas than regular hop products. An example would be Miller Genuine Draft which comes in clear glass.\nPrevention includes use of only brown glass bottles, and deny exposure of fermenting wort in clear glass carboys to any light. It is important for the homebrewer to understand that any exposure to light for a prolonged period of time, even if in brown glass, will cause light-struck conditions. Keep beer in a stable, dark environment while storing until consumption."),
          cell("Medicinal", "Akin to medicine or chemicals in aroma or taste."),
          cell("Mercaptan","The common name for 3-methyl-2-butene-thiol. A compound causing a sulfuric, putrid, skunky aroma, typically due to a reaction between hops' alpha acids and sulfur compounds in the presence of sunlight or electric light. Clear, green and blue bottles are most at risk for developing Mercaptan."),
          cell("Metallic", "The undesirable metallic off-flavor is produced by certain chemicals that are harsh & unpleasant akin to the aroma & taste of a rusty nail, & may make beer undrinkable in extreme cases. Other metallic descriptions include tinny, coinlike, & bloodlike. Primary control metallic off-flavors would be to eliminate all sources of contact with beer & iron/aluminum surfaces, such as unplated mild steel, aluminum & cast iron. Look for high iron concentrations in brewing water (example: Clackamas County, Oregon) & treat or replace accordingly. Furthermore, cleaning stainless steel or copper without passivating (oxidizing the surfaces to form a protective layer of oxide on the metal) can also cause this, especially with new equipment. Lastly, use quality malt products & store them in correct containers under proper conditions."),
          cell("Milky", "Creamy and similar to milk in taste or texture; acceptable in some styles, but also an off-flavor. See diacetyl."),
          cell("Moldy", "Mildewed, damp or decaying aromas."),
          cell("Musty", "Mildewed, moldy or damp in aroma."),
          cell("Oily", "Slick in mouthfeel."),
          cell("Ortho-Chlorophenol", "An off flavor and a phenolic compound. With a taste akin to Band-aids or bearing a medicinal quality, Ortho-Chlorophenol may appear from bacteria, but also from chlorinated water or sanitizers."),
          cell("Overly Alcoholic", "Both an aroma and a mouth-feel. A hot, spicy flavor detected by the nose as a vinous aroma and by the tongue by a warming sensation in the middle of the tongue.\nThis is the end product from the conversion of glucose into carbon dioxide and ethyl alcohol. Other, higher alcohols called fusel oils (eg, propanol, butanol, amyl alcohol) and contribute to vinous aromas and tastes.\nFusel oil production will be a function of the yeast strain used and the fermentation temperature (higher temperatures give more fusel oils)."),
          cell("Oxidized/Stale", "Oxidation manifests as stale, sherry-winey, rotten-fruit or vegetable, cardboard, & papery. The characteristics are perceived in either aroma & flavor or both. Primary causes are old beer, extra oxygen introduced via bottling/kegging, & controlling temperature throughout the process. Avoid too much airspace in the bottle, warm temperatures, & excessive aging; drink your beer when it’s still viable!"),
          cell("Papery", "See stale and Trans-2-nonenal."),
          cell("Phenolic", "Phenolics are more prominent as an off-aroma, but also are imparted in the flavor of beer. It is described as medicinal, band-aid-like, smokey, clove-like, and plastic-like. Except in certain styles where small amounts are appropriate, phenols are hugely unacceptable. There are many sources of contamination:\n• Chlorophenols exist in municipal water supplies and residue from chlorine-based sanitizers. They can affect beer in parts-per-billion (ppb)! Avoidance of both should be given; find a substitute water supply and avoid chlorine-based sanitizers altogether.\n• Phenols extracted from malt during the mash and sparge are polyphenols, also called tannins. They interact with proteins to form chill or permanent haze. If oxidized through hot-side aeration, they create oxidized fusel alcohols. Proper sparging, and avoidance of excessive sparging can reduce the phenolic production. Also, sparge water should be low in alkalinity, and not in excess of 167°F. Likewise, extract brewers should avoid boiling grains.\n• Phenols are also derived from certain yeast strains that produce aromatic alcohols. Bavarian wheat beers produce acceptable levels of phenols by creating 4-vinyl guaiacol that results in a pleasing clovelike phenolic tone under the correct conditions. Careful selection of yeast can eliminate undesired affects.\n• Wild yeast contamination can harbor within plastic-based equipment, such as polyethylene fermenters and plastic hoses. These materials as soft and permeable, hence difficult to clean. Wild yeasts such as S. diatatius produce minor wort phenols that impart medicinal off-flavors. Migration to glass and stainless replacements are the best solution. Also check for defective bottle caps.\n• Smokey phenols are a byproduct of smoked malts, such as in Rauchbier, and Scotch ales. Low amounts are appropriate, but excess use of malt can be overbearing."),
          cell("Rancid", "Offensive or rotten in odor or taste"),
          cell("Soapy", "Having a scent or taste by soap. Soapy flavors can caused by not washing your glass very well, but they can also be produced by the fermentation conditions. If you leave the beer in the primary fermentor for a relatively long period of time after primary fermentation is over (\"long\" depends on the style and other fermentation factors), soapy flavors can result from the breakdown of fatty acids in the trub. Soap is, by definition, the salt of a fatty acid; so you are literally tasting soap."),
          cell("Solvent", "Solvent off-flavors have a pungent, acrid aroma followed by a harsh, burning (not warming) sensation on the back of the tongue that persists in bad cases. The most common cause is from ethyl acetate wherein ethanol is esterified by acetic acid from higher temperature fermentations, though wild yeasts may also impart production of ethyl acetate. Prevention includes proper sterilization of equipment and avoidance of excessive ferment temperatures."),
          cell("Sour/Acidic", "Though appropriate for Lambics, Sour & Acidic flavors are considered contaminants for other styles. They are perceived as a sour aroma, tartness or vinegarlike flavor on the sides of the tongue (such as with lemon juice). The primary causes are Enteric, Lactobacillus, & Pediococcus bacteria which produce lactic & acetic acids. The production of these acids are enhanced by addition of too much refined sugar, citric or ascorbic acid.\nBacterial growth can manifest from mashing too long, contamination from equipment, long lag times before pitching yeast, under-pitching yeast, & excessive fermentation temperatures. To prevent contamination, thoroughly inspect & clean equipment, kegs, & bottles. Do not use wooden spoons on cooled wort, & avoid scratched surfaces, particularly plastic items."),
          cell("Stale", "Synonymous with 'oxidized.'' An off flavor that transpires when beer is exposed to oxygen or high temperatures, or is otherwise past its prime. Stale or oxidized flavors come in a variety of permutations—papery or cardboardlike, akin to rotten produce, diaperlike, leathery, sherrylike and bready are common forms."),
          cell("Sulfury", "Sulfur flavors and aromas manifest in a variety of ways, from very low levels that are imperceptible to very high levels that is best described as rotten eggs. Sulfur-dioxide (SO2) is produced in very low amounts from mashing, but is driven off by a rigorous boil, otherwise the character imparts a sharp, biting flavor and aroma that is accentuated by oxidation. Hydrogen Sulfide (H2S) is created in the boil in the presence of copper and is driven off by both aggressive boiling and warmer ale fermentation by escaping CO2, which explains why lager fermentation is more susceptible. Mutant yeasts that have defective metabolic pathways can produce excessive amounts of H2S that may linger enough to contaminate the flavor of the beer. Light-struck beer can create sulfur compounds because of corruption of the hop flavor. Formation of DMS is also a source from either malting or as a yeast by-product. Enteric bacteria can cause DMS-producing critters, but can be held at bay by good sanitation and by the natural lowering of pH though a healthy ferment by adding sufficient yeast. For larger breweries, recovering the CO2 can result in accumulation of sulfur compounds without proper scrubbing and filtration. Lastly, sulfur contamination can occur from allowing the beer to sit too long on the yeast, thus resulting in the breakdown of yeast walls though autolysis."),
          cell("Trans-2-nonenal", "An off flavor typified by tastes of paper or wet cardboard, usually detected in old or stale beer. Developed during aging, the compound can be thwarted by minimizing air in aging containers and bottles."),
          cell("Vegetal", "Cooked vegetable is an off-flavor described best as cooked corn, cabbage or broccoli. It is caused by low levels of sulfur-based compounds primarily perceived in aroma & to a lesser extent in flavor. Primary source is from malt or malt extract. The first corrective step would be to purchase better quality product. If flavor persists, engage in longer boils to drive off those nasty volitiles. Bacteria may also produce sulfur compounds responsible for cooked vegetable via wort and/or yeast infection. Reuse of yeast without proper controls may introduce bacteria that eventually causes flavor degradation.\nSteps to correct this problem include: sanitation, fresh quality malt products, longer boiling, proper yeast amounts when pitching."),
        ]
      }]
    end
  end

  def cell(title, description)
    c = {
      title: title,
      subtitle: description,
      cell_style: UITableViewCellStyleSubtitle,
      search_text: description.split(/\W+/).uniq.join(" ")
    }

    char_length = Device.ipad? ? 115 : 45

    if description.length < char_length
      c.merge!({
        selection_style: UITableViewCellSelectionStyleNone,
        accessory_type: UITableViewCellAccessoryNone
      })
    else
      c.merge!({
        action: :tapped_cell,
        arguments: { description: description, title: title },
        selection_style: UITableViewCellSelectionStyleGray,
        accessory_type: UITableViewCellAccessoryDisclosureIndicator
      })
    end
    c
  end

  def tapped_cell(args={})
    open_args = args
    open_args = args.merge({search_string: search_string}) if searching?
    open DetailScreen.new(open_args)
  end

end
